//
//  RecommendedTVView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import SwiftUI


struct RecommendedTVView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager

	// MARK: Private Observable Objects
	@StateObject private var dataSource 		= TVRecommendationsDataSource()
	@StateObject private var activityManager	= ActivityManager()

	//MARK: Private Variables
	private let tvId: Int
	
	
	// MARK: SwiftUI
	var body: some View {
		
		DataSourceView(
			dataSource: dataSource,
			activityManager: activityManager,
			alertManager: alertManager,
			movieNetworkManager: environmentManager.movieNetworkManager,
			fetchesOnLoad: true) { results in
				ScrollView(.horizontal, showsIndicators: true) {
					LazyHStack {
						ForEach(results, id: \.equalityId) { searchResult in
							RecommendationResultView(searchResult: searchResult)
							.onAppear {
								dataSource.fetchIfNecessary(searchResult)
							}
						}
					}
				}
			} noResultsContents: {
				HStack {
					Spacer()
					Text("No Recomendations")
					Spacer()
				}
				.frame(maxWidth: .infinity)
			}
			.onAppear {
				dataSource.inject(tvId: tvId)
			}
	}
	
	
	// MARK: Init
	
	init(tvId: Int) {
		self.tvId = tvId
	}
}


// MARK: - Preview
//struct RecommendedTVView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendedTVView()
//    }
//}
