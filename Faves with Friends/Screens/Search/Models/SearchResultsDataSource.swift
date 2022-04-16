//
//  SearchResultsDataSource.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/22/21.
//

import Foundation
import Combine


final class SearchResultsDataSource: ViewDataSource {
	
	// MARK: Constants and Enums
	private enum Constants {
		static let debounceSeconds 		= 1
		static let minSearchTextLength	= 2
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
			
			if shouldSearch(text: searchText) {
				initiateFetch()
			}
		}
	}

	// MARK: Private Variables
	private let searchTextSubject 						= PassthroughSubject<String,Never>()
	private var searchTextCancellable: AnyCancellable?	= nil

	
	// MARK: Init
	
	init() {
		super.init()
		
		searchTextCancellable = searchTextSubject
			.debounce(for: .seconds(Constants.debounceSeconds), scheduler: DispatchQueue.main)
			.filter({ [weak self] text in
				return self?.shouldSearch(text: text) ?? false
			})
			.sink(receiveValue: { [weak self] text in
				self?.resetSearch()
				self?.initiateFetch()
			})
	}

	
	// MARK: ViewDataSource Functions
	
	override func performFetch(page: Int) async throws -> MovieDBSearchResults {
		try await self.movieNetworkManager.search(query: self.searchText, type: self.searchType, page: page)
	}
	
	
	// MARK: Private Functions
	
	private func shouldSearch(text: String) -> Bool {
		if text.isEmpty || text.count < Constants.minSearchTextLength {
			self.resetSearch()
			
			return false
		}
		
		return true
	}
}
