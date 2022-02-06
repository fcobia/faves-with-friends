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
    @EnvironmentObject var favesViewModel: FaveViewModel
    
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
                        .foregroundColor(.black)
						.modifier(ClearButtonModifier(text: $dataSource.searchText))
                        .onAppear {
                            UITextField.appearance().backgroundColor = .white
                        }
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
			
			DataSourceView(
				dataSource: dataSource,
				activityManager: activityManager,
				alertManager: alertManager,
				movieNetworkManager: environmentManager.movieNetworkManager,
				fetchesOnLoad: false) { results in
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
                            .swipeActions {
                                Button {
                                    favesViewModel.addToWatchingList(WatchListItem(videoId: searchResult.id, rating: nil, type: .movie, title: searchResult.name, moviePosterURL: searchResult.image))
                                } label: {
                                    Label("Add to Watching", systemImage: "tv.circle")
                                }
                                Button {
                                    favesViewModel.addToToWatchList(WatchListItem(videoId: searchResult.id, rating: nil, type: .movie, title: searchResult.name, moviePosterURL: searchResult.image))
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
        .navigationBarHidden(true)
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


// MARK: - Preview
struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
