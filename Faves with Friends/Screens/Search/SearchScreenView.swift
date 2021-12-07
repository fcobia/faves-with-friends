//
//  SearchScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/26/21.
//

import SwiftUI
import Combine


struct SearchScreenView: View {
	
	// MARK: Constants and Enums
	private enum Constants {
		static let debounceSeconds 		= 1
		static let minSearchTextLength	= 2
	}

	enum SearchType: String {
		case All
		case Movies
		case TVShows
	}

	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	@EnvironmentObject var activityManager: ActivityManager

	// MARK: State Variables
	@State private var searchText: String 	= ""
	@State private var totalResults: Int	= 0
	@State private var movies: [MovieSearch]		= []
    @State private var searchType: SearchType = .All
    
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
			CurvedHeaderView {
				VStack {
					VStack {
						Text("Faves")
							.font(.largeTitle.weight(.semibold))
							.appAltText()
						
						Text("with friends")
							.font(.footnote)
							.appAltText()
					}
					
					TextField("Search", text: $searchText)
						.appRoundedTextField()
						.modifier(ClearButtonModifier(text: $searchText))
                    
					Picker("", selection: $searchType) {
						Text("All").tag(SearchType.All)
						Text("Movies").tag(SearchType.Movies)
						Text("TV Shows").tag(SearchType.TVShows)
					}
					.pickerStyle(SegmentedPickerStyle())
					.background(Color(UIColor.systemBackground)).opacity(0.8).cornerRadius(8.0)
					.padding(.bottom)
				   
					Text("\(totalResults) Results")
						.font(.subheadline)
						.foregroundColor(.white)
				}
				.padding([.horizontal, .bottom])
			}

			List {
				ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailScreenView(id: movie.id, movieTitle: movie.title)) {
                        SearchScreenRowView(movie: movie)
                    }
				}
				.listRowBackground(Color.clear)
			}
			.listStyle(.plain)
		}
        .navigationBarHidden(true)
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
			
			// Perform the search
			do {
				
				// Show the activity view
				activityManager.showActivity()

				let searchResults = try await environmentManager.movieNetworkManager.movieSearch(query: searchText)
				movies = searchResults.results.compactMap({ $0 as? MovieSearch })
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


// MARK: - Preview
struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
