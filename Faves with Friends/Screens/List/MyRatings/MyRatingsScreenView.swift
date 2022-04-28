//
//  MyRatingsScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/23/21.
//

import SwiftUI
import OrderedCollections

struct MyRatingsScreenView: View {
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FavesManager
	
	
	// MARK: Computed Variables
	private var allWatchedByRating: OrderedDictionary<Double?,[WatchListItem]> {
		let orderedList = favesViewModel.allWatched.sorted { lhs, rhs in
			guard let lr = lhs.rating else { return true }
			guard let rr = rhs.rating else { return false }
			
			// Secondary sort
			if lr == rr {
				return lhs.dateAdded < rhs.dateAdded
			}
			
			return lr > rr
		}

		
		return OrderedDictionary<Double?, [WatchListItem]>(grouping: orderedList, by: { $0.rating })
	}
    
    
    var body: some View {
        List {
			
			ForEach(allWatchedByRating.keys, id: \.self) { rating in
				
				Section(content: {
					ForEach(allWatchedByRating[rating]!, id: \.id) { watchListItem in
						NavigationLink(destination: { destination(for: watchListItem) }) {
							MyRatingsScreenRowView(previewImagePhase: nil, watchListItem: watchListItem)
						}
						.swipeActions {
							Button(role: .destructive) {
								favesViewModel.removeFromWatchedList(watchListItem)
							} label: {
								Label("Delete", systemImage: "minus.circle")
							}
						}
					}
                    .onMove(perform: move)
				}, header: {
					HStack {
						StarsView(rating: rating ?? 0)
						if let unwrapped = rating {
							Text("-")
							Text(RatingName.name(for: unwrapped))
						}
					}
					.padding([.top, .bottom], 10)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color.gray)
				}) {
				}
			}
            .listRowBackground(Color.clear)
        }
        .toolbar {
            EditButton()
        }
        .listStyle(.plain)
        .navigationTitle("Lists")
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // move the data here
    }
    
    // MARK: Private Methods
    private func destination(for video: WatchListItem) -> some View {
        switch video.type {
				
			case .movie:
				return AnyView(MovieDetailScreenView(id: video.videoId, movieTitle: video.title ?? "Unknown"))
				
            case .tv:
                return AnyView(TVDetailScreenView(id: video.videoId, title: video.title ?? "Unknown"))
		}
    }
}

struct MyRatingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyRatingsScreenView()
    }
}
