//
//  MovieDetailScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import SwiftUI

struct MovieDetailScreenView: View {

    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FavesManager
    
    // MARK: State Variables
    @State private var movie: Movie? = nil
    @State private var showingConfirmationDialog = false
    @State private var list: ListType? = nil
    @State private var rating: Double?
    @State private var ratingEnabled = true
	
	// MARK: Computed Variables
	private var watched: Bool {
		list == .Watched
	}
    
    // MARK: Preview Support Variables
    private let previewBackdropPhase: AsyncImagePhase?
    private let previewPosterPhase: AsyncImagePhase?
    
    // MARK: Private Variables
    private let id: Int
    private let movieTitle: String
    
    // MARK: SwiftUI View
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let movie = movie {
                    VStack {
                        MovieDetailHeaderView(movie: movie, previewBackdropPhase: previewBackdropPhase, previewPosterPhase: previewPosterPhase)
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
										favesViewModel.addToToWatchList(movie)
									} label: {
										Text("Add to Watch List")
									}
									.appPrimaryButton()
                                }
								
                                if list == .Watchlist || list == .Watched {
									Button {
										list = .Watching
										favesViewModel.addToWatchingList(movie)
									} label: {
										Text("Add to Watching List")
									}
									.appPrimaryButton()
                                }
                            }
                            .padding(.bottom)
							
							MovieDetailsView(movie: movie)
                        }
                    }
                }
            }
            .background(.background)
            .navigationTitle(movieTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
		.onChange(of: rating, perform: { newValue in
			
			if let movie = movie {
				favesViewModel.updateRating(for: movie, rating: newValue)
				list = favesViewModel.list(for: movie)
			}
		})
		.task {
			if let findResult = favesViewModel.find(videoId: id, type: .movie) {
				rating = findResult.item.rating
				list = findResult.listType
			}
			
			await getMovieDetails(id: id)
		}
    }
    
    
    // MARK: Init
    
    init(id: Int, movieTitle: String, previewBackdropPhase: AsyncImagePhase? = nil, previewPosterPhase: AsyncImagePhase? = nil) {
        self.id = id
        self.movieTitle = movieTitle
        self.previewBackdropPhase = previewBackdropPhase
        self.previewPosterPhase = previewPosterPhase
    }
    
	
    // MARK: Private Methods
	
    private func getMovieDetails(id: Int) async {
		do {
			activityManager.showActivity()
			movie = try await environmentManager.movieNetworkManager.movieDetails(id: id)
			//showProgressView = false
		}
		catch let error {
			print("Error: \(error)")
			//showProgressView = false
			alertManager.showAlert(for: error)
		}
		
		activityManager.hideActivity()
    }
}


struct MovieDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreenView(id: 11, movieTitle: "Star Wars")
            .modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}

