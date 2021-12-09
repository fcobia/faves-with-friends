//
//  MovieDetailScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import SwiftUI

struct MovieDetailScreenView: View {
    
    enum ListType: String {
        case Watchlist
        case Watched
    }
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
	@EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FaveViewModel

	// MARK: State Variables
	@State private var movie: Movie? = nil
    @State private var watched = false
	@State private var showingConfirmationDialog = false
    @State private var list: ListType = .Watchlist
    @State private var rating: Double?
    @State private var ratingEnabled = false
    
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
                            Toggle("Mark as watched:", isOn: $watched)
                                .padding(.horizontal)
                                .onChange(of: watched) { _isOn in
                                    ratingEnabled.toggle()
                                }
                            Button {
                                showingConfirmationDialog.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                            }
                            .confirmationDialog("Add to list", isPresented: $showingConfirmationDialog) {
                                Button("To Watch") {
                                    list = .Watchlist
                                    favesViewModel.addToToWatchList(WatchListItem(videoId: movie.id, rating: rating))
                                }
                                Button("Watched") {
                                    list = .Watched
                                    favesViewModel.addToWatchedList(WatchListItem(videoId: movie.id, rating: rating))
                                }
                            } message: {
                                Text("Add to list")
                            }
                            RatingView(rating: $rating)
                                .allowsHitTesting(ratingEnabled)
                                .padding()
                                .onAppear {
                                    if let index = favesViewModel.watchedList.firstIndex(where: { $0.videoId == movie.id }) {
                                        rating = favesViewModel.watchedList[index].rating
                                        watched = true
                                    }
                                }
                            MovieDetailsView(movie: movie)
                        }
                    }
                }
			}
            .background(.background)
            .navigationTitle(movieTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear() {
			if movie == nil {
				getMovieDetails(id: id)
			}
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
    private func getMovieDetails(id: Int) {
        Task {
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
}


struct MovieDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
		MovieDetailScreenView(id: 11, movieTitle: "Star Wars")
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}

