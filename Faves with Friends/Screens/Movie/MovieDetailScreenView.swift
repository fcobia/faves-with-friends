//
//  MovieDetailScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import SwiftUI

struct MovieDetailScreenView: View {
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
	@EnvironmentObject var activityManager: ActivityManager

	// MARK: State Variables
	@State private var movie: Movie? = nil

	// MARK: Private Variables
    let id: Int
    
    
	// MARK: SwiftUI View
    var body: some View {
        VStack {
            if let movie = movie {
                ZStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topLeading) {
							ImageLoadingView(url: movie.backdropPath) { image in
								MovieDetailHeaderView(image: image)
							}
                            VStack(alignment: .leading) {
                                HStack {
                                    AsyncImage(url: movie.posterPath) { phase in
                                        switch phase {
                                        case .empty:
                                            ZStack {
                                                Rectangle()
                                                    .fill(Color.clear)
                                                    .frame(width: 100, height: 100)
                                                ProgressView()
                                            }
                                        case .success(let image):
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 100, maxHeight: 100)
                                        case .failure:
                                            Image(systemName: "photo")
                                                .frame(width: 100, height: 100)
                                        @unknown default:
                                            // Since the AsyncImagePhase enum isn't frozen,
                                            // we need to add this currently unused fallback
                                            // to handle any new cases that might be added
                                            // in the future:
                                            EmptyView()
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text(movie.title)
                                            .foregroundColor(.white)
                                        Text(movie.releaseDate)
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Form {
                Text("Form test")
            }
        }
        .onAppear() {
			if movie == nil {
				getMovieDetails(id: id)
			}
        }
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
		MovieDetailScreenView(id: 11)
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}

