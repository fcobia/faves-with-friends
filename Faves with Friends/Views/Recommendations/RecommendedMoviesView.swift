//
//  RecommendedMoviesView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import SwiftUI


struct RecommendedMoviesView: View {
	
	// MARK: Environment Variables
	
	// MARK: Environment Variables
	@Environment(\.showModal) var showModal
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	@Environment(\.preferredPalettes) var pallet

	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	@EnvironmentObject var favesViewModel: FaveViewModel

	// MARK: Private Observable Objects
	@StateObject private var dataSource 		= MovieRecommendationsDataSource()
	@StateObject private var activityManager	= ActivityManager()

	//MARK: Private Variables
	private let movieId: Int
	
	// MARK: Private Computed Variables
	private var isSearchResultMode: Bool {
		return showModal.wrappedValue
	}
	
	
	// MARK: SwiftUI
    var body: some View {
		
		Group {
			if isSearchResultMode {
				SearchListView(dataSource: dataSource, fetchesOnLoad: true)
					.toolbar {
						Button("Close") {
							showModal.wrappedValue = false
						}
						.foregroundColor(pallet.color.alternativeText)
					}
			}
			else {
				DataSourceView(
					dataSource: dataSource,
					activityManager: activityManager,
					alertManager: alertManager,
					movieNetworkManager: environmentManager.movieNetworkManager,
					favesViewModel: favesViewModel,
					fetchesOnLoad: true) { results in
						scrollView(results)
					} noResultsContents: {
						HStack {
							Spacer()
							Text("No Recomendations")
							Spacer()
						}
						.frame(maxWidth: .infinity)
					}
			}
		}
		.onAppear {
			dataSource.inject(movieId: movieId)
		}
    }
	
	
	// MARK: Init
    init(movieId: Int) {
		self.movieId = movieId
	}
	
	
	// MARK: Private Methods
	private func scrollView(_ results: [SearchResult]) -> some View {
		Group {
			if isSearchResultMode {
				ScrollView(.vertical, showsIndicators: true) {
					LazyVStack {
						forEachView(results)
					}
				}
			}
			else {
				ScrollView(.horizontal, showsIndicators: true) {
					LazyHStack {
						forEachView(results)
					}
				}
			}
		}
	}
	
	private func forEachView(_ results: [SearchResult]) -> some View {
		ForEach(results, id: \.equalityId) { searchResult in
			contentView(searchResult: searchResult)
				.onAppear {
					dataSource.fetchIfNecessary(searchResult)
				}
		}
	}
	
	private func contentView(searchResult: SearchResult) -> some View {
		RecommendationResultView(searchResult: searchResult)
	}
}


// MARK: - Preview
struct RecommendedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
		RecommendedMoviesView(movieId: 11)
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
