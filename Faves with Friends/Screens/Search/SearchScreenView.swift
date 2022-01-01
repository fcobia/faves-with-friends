//
//  SearchScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/26/21.
//

import SwiftUI
import Combine


struct SearchScreenView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	
	// MARK: Private Observable Objects
	@ObservedObject private var dataSource 		= SearchResultsDataSource()
	@ObservedObject private var activityManager	= ActivityManager()

	
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
					
					TextField("Search", text: $dataSource.searchText)
						.appRoundedTextField()
						.modifier(ClearButtonModifier(text: $dataSource.searchText))
                    
					Picker("", selection: $dataSource.searchType) {
						ForEach(SearchType.allCases) { type in
							Text(type.rawValue).tag(type)
						}
					}
					.pickerStyle(SegmentedPickerStyle())
					.background(Color(UIColor.systemBackground)).opacity(0.8).cornerRadius(8.0)
					.padding(.bottom)
				   
					Text("\(dataSource.totalResults) Results")
						.font(.subheadline)
						.foregroundColor(.white)
				}
				.padding([.horizontal, .bottom])
			}

			if let results = dataSource.results {
				if results.isEmpty == false {
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
						}
						.listRowBackground(Color.clear)
						
						if activityManager.shouldShowActivity {
							LoadingRowView()
						}
					}
					.listStyle(.plain)
				}
				else {
					HStack {
						Spacer()
						Text("No Results")
						Spacer()
					}
					.frame(maxHeight: .infinity)
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
        .navigationBarHidden(true)
		.onAppear {
			dataSource.inject(alertManager: alertManager, activityManager: activityManager, movieNetworkManager: environmentManager.movieNetworkManager)
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
}


// MARK: - Preview
struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
