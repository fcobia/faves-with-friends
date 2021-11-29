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
		static let minSearchTextLength	= 2
	}
	
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	
	// MARK: State Variables
	@State private var searchText: String 	= ""
	@State private var totalResults: Int	= 0
	@State private var movies: [MovieSearchResultObject]		= []
    @State private var showProgressView     = false
    @State private var searchType: SearchType = .All
    
	// MARK: Private Computed Values
	private var searchTextPublisher: AnyPublisher<String,Never> {
		searchTextSubject
			.debounce(for: .seconds(Constants.debounceSeconds), scheduler: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	// MARK: Private Variables
	private let searchTextSubject = PassthroughSubject<String,Never>()

    enum SearchType: String {
        case All
        case Movies
        case TVShows
    }
	
	// MARK: SwiftUI
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .blue, location: 0.1),
                .init(color: .white, location: 0.1)
            ], center: .top, startRadius: 300, endRadius: 500)
                .ignoresSafeArea(edges: .top)
            VStack {
                VStack {
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
                   
                    Text("Result(s): \(totalResults)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                List {
                    ForEach(movies) { movie in
                        NavigationLink(destination: Text(movie.title)) {
                            SearchScreenRowView(movie: movie)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .padding(.top, 50)
                .listStyle(.plain)
                .overlay {
                    if showProgressView {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .background(Color(UIColor.clear))
                    }
                }
            }
        }
        .navigationTitle("Faves with Friends")
		.onChange(of: searchText) { newValue in
            if (newValue.count > 0) {
                showProgressView = true
            } else {
                showProgressView = false
            }
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
				showProgressView = false
				movies = searchResults.results ?? []
				totalResults = searchResults.totalResults
			}
			catch let error {
				print("Error: \(error)")
                showProgressView = false
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
