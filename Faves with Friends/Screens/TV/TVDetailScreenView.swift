//
//  TVDetailScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import SwiftUI

struct TVDetailScreenView: View {
	
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FavesManager
    
	// MARK: Private Variables
	private let id: Int
	private let title: String

    // MARK: State Variables
    @State private var tvShow: TV? = nil
    @State private var list: ListType? = nil
    @State private var rating: Double?
    @State private var ratingEnabled = true
	
	// MARK: Computed Variables
	private var watched: Bool {
		return list == .Watched
	}
    
    // MARK: Preview Support Variables
    private let previewBackdropPhase: AsyncImagePhase?
    private let previewPosterPhase: AsyncImagePhase?
    
	// MARK: SwiftUI View
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let tvShow = tvShow {
                    VStack {
                        TVShowDetailHeaderView(tvShow: tvShow, previewBackdropPhase: previewBackdropPhase, previewPosterPhase: previewPosterPhase)
                            .frame(height: geometry.size.height / 3)
                    }
                    ScrollView {
                        VStack {
                            HStack {
                                Text("List: \(list?.displayName ?? "None")")
                                Spacer()
                            }
                            
                            StarRatingView($rating, size: 36)
                                .allowsHitTesting(ratingEnabled)
                                .padding()
                            
                            HStack {
                                if list == .none || list == .Watched {
                                    Button {
                                        list = .Watchlist
                                        favesViewModel.addToToWatchList(tvShow)
                                    } label: {
                                        Text("Add to Watch List")
                                    }
                                    .appPrimaryButton()
                                }
                                
                                if list == .Watchlist || list == .Watched {
                                    Button {
                                        list = .Watching
                                        favesViewModel.addToWatchingList(tvShow)
                                    } label: {
                                        Text("Add to Watching List")
                                    }
                                    .appPrimaryButton()
                                }
                            }
                            .padding(.bottom)
                            
                            TVShowDetailsView(tvShow: tvShow)
                        }
                    }
                }
            }
            .background(.background)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: rating, perform: { newValue in
			guard let tvShow = tvShow else {
				return
			}

			favesViewModel.updateRating(for: tvShow, rating: newValue)
			list = favesViewModel.list(for: tvShow)
        })
        .task {
            if let index = favesViewModel.watchedList.firstIndex(where: { $0.videoId == id }) {
                rating = favesViewModel.watchedList[index].rating
				list = .Watched
            }
            if let _ = favesViewModel.toWatchList.firstIndex(where: { $0.videoId == id }) {
				list = .Watchlist
            }
            if let _ = favesViewModel.watchingList.firstIndex(where: { $0.videoId == id }) {
				list = .Watching
            }
            
            await getTVDetails(id: id)
        }
    }
	
	
	// MARK: Init
	init(id: Int, title: String, previewBackdropPhase: AsyncImagePhase? = nil, previewPosterPhase: AsyncImagePhase? = nil) {
		self.id = id
		self.title = title
        self.previewBackdropPhase = previewBackdropPhase
        self.previewPosterPhase = previewPosterPhase
	}
    
	
	// MARK: Private Methods
    private func getTVDetails(id: Int) async {
        do {
            activityManager.showActivity()
            tvShow = try await environmentManager.movieNetworkManager.tvDetails(id: id)
        }
        catch let error {
            print("Error: \(error)")
            alertManager.showAlert(for: error)
        }
        
        activityManager.hideActivity()
    }
}


// MARK: - Preview
//struct TVDetailScreenViewView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVDetailScreenView()
//    }
//}
