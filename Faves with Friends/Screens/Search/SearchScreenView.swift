//
//  SearchScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/26/21.
//

import SwiftUI
import Combine


struct SearchScreenView: View {
	
	// MARK: Constants
	private enum Constants {
		static let debounceSeconds 		= 1
		static let minSearchTextLength	= 3
	}
	
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	
	// MARK: State Variables
	@State private var searchText: String 	= ""
	@State private var totalResults: Int	= 0
	@State private var movies: [Movie]		= []
	
	// MARK: Private Computed Values
	private var searchTextPublisher: AnyPublisher<String,Never> {
		searchTextSubject
			.debounce(for: .seconds(Constants.debounceSeconds), scheduler: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	// MARK: Private Variables
	private let searchTextSubject = PassthroughSubject<String,Never>()

	
	// MARK: SwiftUI
    var body: some View {
        
		VStack {
			TextField("Search", text: $searchText)
				.appTextField()
			
			Text("Result(s): \(totalResults)")
			
			List(movies) { movie in
				Text(movie.title)
			}
		}
		.padding()
		.onChange(of: searchText) { newValue in
			searchTextSubject.send(searchText)
		}
		.onReceive(searchTextPublisher) { searchText in
			
			// Did we get a long enough string
			if searchText.count > Constants.minSearchTextLength {
				performSearch(searchText: searchText)
			}
			else {
				movies = []
				totalResults = 0
			}
		}
    }
	
	
	// MARK: Private Methods
	private func performSearch(searchText: String) {
		Task {
			do {
				let searchResults = try await environmentManager.movieNetworkManager.movieSearch(query: searchText)
				
				movies = searchResults.results ?? []
				totalResults = searchResults.totalResults
			}
			catch let error {
				print("Error: \(error)")
				alertManager.showAlert(for: error)
			}
		}
	}
}


// MARK: - Preview
struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
