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
	
    @State private var filter = SearchType.all
    @State private var list = OrderedDictionary<Double?,[WatchListItem]>()
	
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
    
    private var moviesWatchedByRating: OrderedDictionary<Double?, [WatchListItem]> {
        let filteredOrderedList = favesViewModel.allWatched.filter { $0.type == .movie }.sorted { lhs, rhs in
            guard let lr = lhs.rating else { return true }
            guard let rr = rhs.rating else { return false }
            
            // Secondary sort
            if lr == rr {
                return lhs.dateAdded < rhs.dateAdded
            }
            
            return lr > rr
        }
        
        return OrderedDictionary<Double?, [WatchListItem]>(grouping: filteredOrderedList, by: { $0.rating })
    }
    
    private var tvWatchedByRating: OrderedDictionary<Double?, [WatchListItem]> {
        let filteredOrderedList = favesViewModel.allWatched.filter { $0.type == .tv }.sorted { lhs, rhs in
            guard let lr = lhs.rating else { return true }
            guard let rr = rhs.rating else { return false }
            
            // Secondary sort
            if lr == rr {
                return lhs.dateAdded < rhs.dateAdded
            }
            
            return lr > rr
        }
        
        return OrderedDictionary<Double?, [WatchListItem]>(grouping: filteredOrderedList, by: { $0.rating })
    }
    
    var body: some View {
        Picker("", selection: $filter) {
            ForEach(SearchType.allCases) { type in
                if type != .person {
                    Text(type.rawValue).tag(type)
                }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: filter) { value in
                switch value {
                case .all:
                    list = allWatchedByRating
                case .movies:
                    list = moviesWatchedByRating
                case .tv:
                    list = tvWatchedByRating
                case .person:
                    list = allWatchedByRating
                }
        }
        .onAppear() {
                switch filter {
                case .all:
                    list = allWatchedByRating
                case .movies:
                    list = moviesWatchedByRating
                case .tv:
                    list = tvWatchedByRating
                case .person:
                    list = allWatchedByRating
                }
        }
        .background(Color(UIColor.systemBackground)).opacity(0.8).cornerRadius(8.0)
        .padding()
       
        List {
			
			ForEach(list.keys, id: \.self) { rating in
				
				Section(content: {
					ForEach(list[rating]!, id: \.id) { watchListItem in
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
                            Text("-")
                            Text("Count: \(allWatchedByRating[rating]!.count)")
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
        .navigationBarTitle(("Lists"), displayMode: .inline)
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
