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
	@Published private(set)	var totalResults: Int			= 0
	
	// MARK: Init Variables
	private var alertManager: AlertManager!
	private var activityManager: ActivityManager!
	private var movieNetworkManager: MovieNetworkManager!

	// MARK: Private Variables
	private let searchTextSubject 						= PassthroughSubject<String,Never>()
	private var searchTextCancellable: AnyCancellable?	= nil
	
	
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
	
	
	// MARK: Private Functions
	
	private func clearSearchResults() {
		results = nil
		totalResults = 0
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

		// Perform the search asynchronously
		Task {
			
			// Perform the search
			do {
				
				// Show the activity view
				activityManager.showActivity()

				let searchResults = try await movieNetworkManager.search(query: searchText, type: searchType, page: 1)
				results = searchResults.results
				totalResults = searchResults.totalResults
			}
			catch let error {
				print("Error: \(error)")
				alertManager.showAlert(for: error)
			}
			
			// Hide teh activity view
			activityManager.hideActivity()
		}
	}
}
