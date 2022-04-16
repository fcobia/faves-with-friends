//
//  DataSourceView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import SwiftUI


struct DataSourceView<ResultContent: View, NoResultContent: View>: View {

	// MARK: Private Observable Objects
	@ObservedObject private var dataSource: ViewDataSource
	@ObservedObject private var activityManager: ActivityManager
	
	// MARK: Private State Variables
	@State private var hasFetched	= false
	
	// MARK: Init Variables
	private let fetchesOnLoad: Bool
	private let resultsContents: ([SearchResult]) -> ResultContent
	private let noResultsContents: () -> NoResultContent

	
	// MARK: SwiftUI
    var body: some View {
		Group {
			if let results = dataSource.results {
				if results.isEmpty == false {
					resultsContents(results)
					
					if activityManager.shouldShowActivity {
						LoadingRowView()
					}
				}
				else {
					noResultsContents()
				}
			}
			else {
				if activityManager.shouldShowActivity {
					LoadingRowView()
				}
				else {
					Text("")
						.frame(maxHeight: .infinity)
				}
			}
		}
		.onAppear {
			guard fetchesOnLoad && !hasFetched else { return }
			
			dataSource.initiateFetch()
		}
    }
	
	
	// MARK: Init
	init(
		dataSource: ViewDataSource,
		activityManager: ActivityManager,
		alertManager: AlertManager,
		movieNetworkManager: MovieNetworkManager,
		favesViewModel: FavesManager,
		fetchesOnLoad: Bool,
		@ViewBuilder resultsContents: @escaping ([SearchResult]) -> ResultContent,
		@ViewBuilder noResultsContents: @escaping () -> NoResultContent)
	{
		self.dataSource = dataSource
		self.activityManager = activityManager
		self.fetchesOnLoad = fetchesOnLoad
		
		self.resultsContents = resultsContents
		self.noResultsContents = noResultsContents
		
		dataSource.inject(alertManager: alertManager, activityManager: activityManager, movieNetworkManager: movieNetworkManager, favesViewModel: favesViewModel)
	}
}


// MARK: - Preview
//struct DataSourceView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataSourceView()
//    }
//}
