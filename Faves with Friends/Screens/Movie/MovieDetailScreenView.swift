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
        VStack {
            if let movie = movie {
                ZStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topLeading) {
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
                                        .ignoresSafeArea()
                                        .overlay {
                                            Rectangle()
                                                .fill(Color.gray)
                                                .opacity(0.50)
                                                .frame(maxWidth: .infinity, maxHeight: 300)
                                                .ignoresSafeArea()
                                        }
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
            } else {
                ProgressView()
            }
            Form {
                Text("Form test")
            }
        }
        .onAppear() {
            getMovieDetails(id: id)
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

