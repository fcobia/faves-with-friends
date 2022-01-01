//
//  ViewDataSource.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/28/21.
//

import Foundation
import Combine


class ViewDataSource: ObservableObject {
	
	// MARK: Public Computed Variables
	var hasEmptyResults: Bool {
		if let results = results, results.isEmpty {
			return true
		}
		else {
			return false
		}
	}
	
	// MARK: Public Read-Only Published Variables
	@Published private(set) var results: [SearchResult]?	= nil

	// MARK: Public Read-Only Variables
	private(set) var totalResults: Int	= 0

	// MARK: Init Variables
	private(set) var alertManager: AlertManager!
	private(set) var activityManager: ActivityManager!
	private(set) var movieNetworkManager: MovieNetworkManager!

	// MARK: Private Variables
	private let loadingCoordinator						= LoadingCoordinator()
	private var resultIds: Set<String>					= []
	private var nextPage: Int							= 0
	private var totalPages: Int							= 0
	private var nextFetchIndex: Int						= 0

	
	// MARK: Init
	
	init() {
	}
	
	
	// MARK: Subclass Functions
	
	func performFetch(page: Int) async throws -> MovieDBSearchResults {
		fatalError("Not implemented")
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
		guard let currentIndex = results?.firstIndex(where: { $0.equalityId == itemId }) else { return }
		
		// Perform the search if necessary
		if currentIndex >= nextFetchIndex {
			initiateFetch()
		}
	}
	
	func resetSearch() {
		clearSearchResults()
		
		initiateFetch()
	}
	
	func initiateFetch() {
		
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
				let fetchResults = try await performFetch(page: nextPage)
				
				// Take total counts
				totalResults = fetchResults.totalResults
				totalPages = fetchResults.totalPages
				
				// Remove duplicate results
				let filteredResults:[SearchResult] = fetchResults.results.filter({ resultIds.contains($0.equalityId) == false })
				
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

	
	// MARK: Private Functions
	
	private func clearSearchResults() {
		results = nil
		nextPage = 0
		totalResults = 0
		totalPages = 0
		nextFetchIndex = 0
	}
}


// MARK: - LoadingCoordinator
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
