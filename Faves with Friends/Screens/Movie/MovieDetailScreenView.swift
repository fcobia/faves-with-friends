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
        case Watching
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
    @State private var ratingEnabled = true
    
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
                            
                            Button {
                                showingConfirmationDialog.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                            }
                            .confirmationDialog("Add to list", isPresented: $showingConfirmationDialog) {
                                Button("To Watch") {
                                    list = .Watchlist
                                    favesViewModel.addToToWatchList(createWatchListItem(movie))
                                }
                                Button("Watched") {
                                    list = .Watched
                                    favesViewModel.addToWatchedList(createWatchListItem(movie))
                                }
                                Button("Watching") {
                                    list = .Watching
                                    favesViewModel.addToWatchingList(createWatchListItem(movie))
                                }
                            } message: {
                                Text("Add to list")
                            }
                            StarRatingView($rating, size: 36)
                                .allowsHitTesting(ratingEnabled)
                                .padding()

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
			if let movie = movie, let index = favesViewModel.watchedList.firstIndex(where: { $0.videoId == id }) {
				favesViewModel.watchedList[index] = createWatchListItem(movie)
			}
		})
		.task {
			if let index = favesViewModel.watchedList.firstIndex(where: { $0.videoId == id }) {
				rating = favesViewModel.watchedList[index].rating
				watched = true
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
	
	private func createWatchListItem(_ movie: Movie) -> WatchListItem {
		.init(videoId: movie.id, rating: rating, type: .movie, title: movie.title, moviePosterURL: movie.posterPath)
	}
}


struct MovieDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreenView(id: 11, movieTitle: "Star Wars")
            .modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}

