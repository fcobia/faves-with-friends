//
//  SearchResultsDataSource.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/22/21.
//

import Foundation
import Combine


final class SearchResultsDataSource: ObservableObject {
	
	// MARK: Constants and Enums
	private enum Constants {
		static let debounceSeconds 		= 1
		static let minSearchTextLength	= 2
	}

	
	// MARK: Public Computed Variables
	var hasEmptyResults: Bool {
		if let results = results, results.isEmpty {
			return true
		}
		else {
			return false
		}
	}
	
	// MARK: Public Published Variables
	@Published var searchText: String 			= "" {
		didSet {
			searchTextSubject.send(searchText)
		}
	}
	@Published var searchType: SearchType		= .all {
		didSet {
			resetSearch()
		}
	}
	
	// MARK: Public Read-Only Published Variables
	@Published private(set) var results: [SearchResult]?	= nil

	// MARK: Public Read-Only Variables
	private(set) var totalResults: Int	= 0

	// MARK: Init Variables
	private var alertManager: AlertManager!
	private var activityManager: ActivityManager!
	private var movieNetworkManager: MovieNetworkManager!

	// MARK: Private Variables
	private let loadingCoordinator						= LoadingCoordinator()
	private let searchTextSubject 						= PassthroughSubject<String,Never>()
	private var searchTextCancellable: AnyCancellable?	= nil
	private var resultIds: Set<String>					= []
	private var nextPage: Int							= 0
	private var totalPages: Int							= 0
	private var nextFetchIndex: Int						= 0

	
	// MARK: Init
	
	init() {
		searchTextCancellable = searchTextSubject
			.debounce(for: .seconds(Constants.debounceSeconds), scheduler: DispatchQueue.main)
			.sink(receiveValue: { [weak self] text in
				self?.performSearch(searchText: text)
			})
	}
	
	
	// MARK: Public Functions
	
	func inject(alertManager: AlertManager, activityManager: ActivityManager, movieNetworkManager: MovieNetworkManager) {
		self.alertManager = alertManager
		self.activityManager = activityManager
		self.movieNetworkManager = movieNetworkManager
	}
	
	func fetchIfNecessary(_ item: SearchResult) {
		
		// Check the index
		let itemId = item.equalityId
		guard let currentIndex = results?.firstIndex(where: {$0.equalityId == itemId }) else { return }
		
		// Perform the search if necessary
		if currentIndex >= nextFetchIndex {
			performSearch(searchText: searchText)
		}
	}
	
	
	// MARK: Private Functions
	
	private func clearSearchResults() {
		results = nil
		nextPage = 0
		totalResults = 0
		totalPages = 0
		nextFetchIndex = 0
	}
	
	private func resetSearch() {
		clearSearchResults()
		
		performSearch(searchText: searchText)
	}
	
	private func performSearch(searchText: String) {
	
		// Did we get a long enough string
		guard searchText.count > Constants.minSearchTextLength else {
			clearSearchResults()
			
			return
		}
		
		// Make sure there are more pages
		guard nextPage == 0 || nextPage < totalPages else { return }

		// Perform the search asynchronously
		Task {
			
			// Perform the search
			do {
				
				// Make sure we do not load two at once
				guard await loadingCoordinator.startLoading() == true else { return }
				
				// Show the activity view
				activityManager.showActivity()

				// Perform the search
				let searchResults = try await movieNetworkManager.search(query: searchText, type: searchType, page: nextPage)
				
				// Take total counts
				totalResults = searchResults.totalResults
				totalPages = searchResults.totalPages
				
				// Remove duplicate results
				let filteredResults = searchResults.results.filter({ resultIds.contains($0.equalityId) == false })
				
				// Set the results
				if let results = results {
					self.results = results + filteredResults
				}
				else {
					results = filteredResults
				}
				
				// Calculate the next fetch index
				if nextPage < totalPages {
					nextFetchIndex = (results?.count ?? 0) - Int(Double(filteredResults.count) * 0.25)
				}
				else {
					nextFetchIndex = totalResults + 1
				}
				
				// Keep track of the results already loaded
				filteredResults.forEach({ resultIds.insert($0.equalityId) })
				
				// Increment the current page number
				nextPage += 1
				
				// Hide the activity view
				activityManager.hideActivity()
				
				// Finish the loading
				await loadingCoordinator.endLoading()
			}
			catch let error {
				print("Error: \(error)")
				alertManager.showAlert(for: error)
			}
		}
	}
}


private actor LoadingCoordinator {
	private var isLoading: Bool = false
	
	func startLoading() -> Bool {
		guard isLoading == false else { return false }
		
		isLoading = true
		
		return true
	}
	
	func endLoading() {
		isLoading = false
	}
}
