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
    
    @Environment(\.showModal) var showModal
    
    // MARK: State Variables
    @State private var movie: Movie? = nil
    @State private var showingConfirmationDialog = false
    @State private var list: ListType? = nil
    @State private var rating: Double?
    @State private var ratingEnabled = true
    @State private var showRecommended = false
    
    // MARK: Computed Variables
    private var watched: Bool {
        list == .watched
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
                                if list == .none || list == .watched {
                                    Button {
                                        list = .toWatch
                                        if let movieRating = rating {
                                            favesViewModel.addToToWatchList(movie, rating: movieRating)
                                        } else {
                                            favesViewModel.addToToWatchList(movie)
                                        }
                                    } label: {
                                        Text("Add to Watch List")
                                    }
                                    .appPrimaryButton()
                                }
                                
                                
                                Button {
                                    showRecommended = true
                                } label: {
                                    Text("Rate Similar")
                                }
                                .appPrimaryButton()
                                .sheet(isPresented: $showRecommended) {
                                    NavigationView {
                                        RecommendedMoviesViewVertical(movieId: movie.id)
                                            .navigationTitle("Rate Similar")
                                            .navigationBarTitleDisplayMode(.inline)
                                    }
                                    .environment(\.showModal, $showRecommended)
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

