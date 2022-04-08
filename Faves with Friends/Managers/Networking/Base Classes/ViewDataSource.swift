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
	private 		let batchSize: Int
	private(set) 	var alertManager: AlertManager!
	private(set) 	var activityManager: ActivityManager!
	private(set) 	var movieNetworkManager: MovieNetworkManager!
	private(set)	var favesViewModel: FaveViewModel!

	// MARK: Private Variables
	private let loadingCoordinator						= LoadingCoordinator()
	private var resultIds: Set<String>					= []
	private var nextPage: Int							= 0
	private var totalPages: Int							= 0
	private var nextFetchIndex: Int						= 0

	
	// MARK: Init
	
	init(batchSize: Int = 20) {
		self.batchSize = batchSize
	}
	
	
	// MARK: Subclass Functions
	
	func performFetch(page: Int) async throws -> MovieDBSearchResults {
		fatalError("Not implemented")
	}
	
	func filterResults(_ results: [SearchResult]) async throws -> [SearchResult] {
		results
	}
	
	
	// MARK: Public Functions
	
	func inject(alertManager: AlertManager, activityManager: ActivityManager, movieNetworkManager: MovieNetworkManager, favesViewModel: FaveViewModel) {
		self.alertManager = alertManager
		self.activityManager = activityManager
		self.movieNetworkManager = movieNetworkManager
		self.favesViewModel = favesViewModel
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
				
				// Loop until we get enough results
				var filteredResults: [SearchResult] = []
				while (filteredResults.count < batchSize && (nextPage == 0 || nextPage < totalPages)) {
					
					// Perform the search
					let fetchResults = try await performFetch(page: nextPage)
					
					// Take total counts
					totalResults = fetchResults.totalResults
					totalPages = fetchResults.totalPages
					
					// Remove duplicate results
					let localDuplicateFiltered = fetchResults.results.filter({ resultIds.contains($0.equalityId) == false })
					
					// Filter by the data source
					let localFiltered = try await filterResults(localDuplicateFiltered)
					filteredResults.append(contentsOf: localFiltered)
					
					// Keep track of the results already loaded
					filteredResults.forEach({ resultIds.insert($0.equalityId) })

					// Increment the current page number
					nextPage += 1
				}
				
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
		resultIds = []
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
