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
    
    let id: Int
    
    @State private var movie: Movie? = nil
    
    var body: some View {
        NavigationView {
            Form {
                if let movie = movie {
                    AsyncImage(url: movie.backdropPath) { phase in
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
                                 .frame(maxWidth: .infinity, maxHeight: 300)
                        case .failure:
                            Image(systemName: "photo")
                                .frame(width: .infinity, height: 300)
                        @unknown default:
                            // Since the AsyncImagePhase enum isn't frozen,
                            // we need to add this currently unused fallback
                            // to handle any new cases that might be added
                            // in the future:
                            EmptyView()
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .onAppear() {
                getMovieDetails(id: id)
            }
        }
    }
    
    // MARK: Private Methods
    private func getMovieDetails(id: Int) {
        Task {
            do {
                movie = try await environmentManager.movieNetworkManager.movieDetails(id: id)
                //showProgressView = false
            }
            catch let error {
                print("Error: \(error)")
                //showProgressView = false
                alertManager.showAlert(for: error)
            }
        }
    }
}

//struct MovieDetailScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailScreenView()
//    }
//}
