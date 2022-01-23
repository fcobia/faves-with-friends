//
//  MovieDetailScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import SwiftUI

struct MovieDetailScreenView: View {
    

    enum ListType: String, CaseIterable, Identifiable {
        case NoList     = "None"
        case ToWatch    = "ToWatch"
        case Watching   = "Watching"
        case Watched    = "Watched"
        
        var id: String {
            self.rawValue
        }
    }
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    @Environment(\.preferredPalettes) var palettes
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FaveViewModel
    
    // MARK: State Variables
    @State private var movie: Movie? = nil
    @State private var watched = false
    @State private var showingConfirmationDialog = false
    @State private var list: ListType = .NoList
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
                            HStack {
                                Picker("", selection: $list) {
                                    ForEach(ListType.allCases) { type in
                                        Text(type.rawValue).tag(type)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .background(palettes.color.primary).opacity(0.8).cornerRadius(8.0)
                                .padding(.bottom)
                                .onAppear {
                                    if favesViewModel.watchedList.firstIndex(where: { $0.videoId == movie.id }) != nil {
                                        list = .Watched
                                    } else if favesViewModel.toWatchList.firstIndex(where: { $0.videoId == movie.id }) != nil {
                                        list = .ToWatch
                                    } else if favesViewModel.watchingList.firstIndex(where: { $0.videoId == movie.id }) != nil {
                                        list = .Watching
                                    }
                                }
                                .onChange(of: list) { value in
                                    switch value {
                                    case .NoList:
                                        favesViewModel.removeFromWatchedList(WatchListItem(videoId: movie.id, rating: rating, type: .movie, title: movie.title, moviePosterURL: movie.posterPath))
                                            favesViewModel.removeFromWatchingList(WatchListItem(videoId: movie.id, rating: rating, type: .movie, title: movie.title, moviePosterURL: movie.posterPath))
                                           favesViewModel .removeFromToWatchList(WatchListItem(videoId: movie.id, rating: rating, type: .movie, title: movie.title, moviePosterURL: movie.posterPath))
                                    case .Watching:
                                        favesViewModel.addToWatchingList(WatchListItem(videoId: movie.id, rating: rating, type: .movie, title: movie.title, moviePosterURL: movie.posterPath))
                                    case .ToWatch:
                                        favesViewModel.addToToWatchList(WatchListItem(videoId: movie.id, rating: rating, type: .movie, title: movie.title, moviePosterURL: movie.posterPath))
                                    case .Watched:
                                        favesViewModel.addToWatchedList(WatchListItem(videoId: movie.id, rating: rating, type: .movie, title: movie.title, moviePosterURL: movie.posterPath))
                                    }
                                }
                            }
                            .padding(.horizontal)
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

