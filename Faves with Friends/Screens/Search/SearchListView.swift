//
//  SearchListView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 3/28/22.
//

import SwiftUI
import Combine


struct SearchListView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	@EnvironmentObject var favesViewModel: FaveViewModel
	
	// MARK: Private StateObject Objects
	@StateObject private var activityManager	= ActivityManager()
	
	// MARK: Private Observed Objects
	@ObservedObject private var dataSource: ViewDataSource
	
	// Private Variables
	private let fetchesOnLoad: Bool

	
	// MARK: SwiftUI
    var body: some View {
		DataSourceView(
			dataSource: dataSource,
			activityManager: activityManager,
			alertManager: alertManager,
			movieNetworkManager: environmentManager.movieNetworkManager,
			fetchesOnLoad: fetchesOnLoad) { results in
				List {
					ForEach(results, id: \.equalityId) { searchResult in
						NavigationLink(destination: { destination(for: searchResult) }) {
							HStack {
								SearchScreenRowView(searchResult: searchResult)
									.onAppear {
										dataSource.fetchIfNecessary(searchResult)
									}
							}
						}
						.swipeActions(allowsFullSwipe: false) {
							Button {
								favesViewModel.addToWatchingList(WatchListItem(videoId: searchResult.id, rating: nil, type: .movie, title: searchResult.name, moviePosterURL: searchResult.image, list: ListType.Watching.rawValue))
							} label: {
								Label("Add to Watching", systemImage: "tv.circle")
							}
							Button {
								favesViewModel.addToToWatchList(WatchListItem(videoId: searchResult.id, rating: nil, type: .movie, title: searchResult.name, moviePosterURL: searchResult.image, list: ListType.Watchlist.rawValue))
							} label: {
								Label("Add to To Watch", systemImage: "list.bullet.circle")
							}
							.tint(.indigo)
						}
					}
					.listRowBackground(Color.clear)
				}
				.listStyle(.plain)
			} noResultsContents: {
				HStack {
					Spacer()
					Text("No Results")
					Spacer()
				}
				.frame(maxHeight: .infinity)
			}
    }
	
	
	// MARK: Init
	init(dataSource: ViewDataSource, fetchesOnLoad: Bool) {
		self.dataSource = dataSource
		self.fetchesOnLoad = fetchesOnLoad
	}
	
	
	// MARK: Private Methods
	private func destination(for searchResult: SearchResult) -> some View {
		switch searchResult.type {
				
			case .movie:
				return AnyView(MovieDetailScreenView(id: searchResult.id, movieTitle: searchResult.name))
				
			case .tv:
				return AnyView(TVDetailScreenView(id: searchResult.id, title: searchResult.name))
				
			case .person:
				return AnyView(PersonDetailScreenView(id: searchResult.id, title: searchResult.name))
		}
	}
}



//struct SearchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchListView()
//    }
//}
