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

	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	@EnvironmentObject var activityManager: ActivityManager

	// MARK: State Variables
	@State private var searchText: String 		= ""
	@State private var totalResults: Int		= 0
	@State private var results: [SearchResult]	= []
	@State private var searchType: SearchType	= .all
    
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
						ForEach(SearchType.allCases) { type in
							Text(type.rawValue).tag(type)
						}
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
				ForEach(results, id: \.id) { searchResult in
					NavigationLink(destination: { destination(for: searchResult) }) {
                        SearchScreenRowView(searchResult: searchResult)
                    }
				}
				.listRowBackground(Color.clear)
			}
			.listStyle(.plain)
		}
        .navigationBarHidden(true)
		.onChange(of: searchText) { newValue in
			searchTextSubject.send(newValue)
		}
		.onChange(of: searchType) { _ in
			searchTextSubject.send(searchText)
		}
		.onReceive(searchTextPublisher) { searchText in
			performSearch(searchText: searchText)
		}
    }
	
	
	// MARK: Private Methods
	private func destination(for searchResult: SearchResult) -> some View {
		switch searchResult.type {
				
			case .movie:
				return AnyView(MovieDetailScreenView(id: searchResult.id, movieTitle: searchResult.name))
				
			case .tv:
				return AnyView(EmptyView())
				
			case .person:
				return AnyView(EmptyView())
		}
	}
	
	private func performSearch(searchText: String) {
	
		// Did we get a long enough string
		guard searchText.count > Constants.minSearchTextLength else {
			results = []
			totalResults = 0
			
			return
		}

		// Perform the search asynchronously
		Task {
			
			// Perform the search
			do {
				
				// Show the activity view
				activityManager.showActivity()

				let searchResults = try await environmentManager.movieNetworkManager.search(query: searchText, type: searchType)
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


// MARK: - Preview
struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
