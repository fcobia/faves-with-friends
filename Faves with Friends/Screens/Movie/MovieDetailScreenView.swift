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
								.frame(height: geometry.size.height / 2)
						}
				}
				
				VStack {
					Text("Form test")
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

