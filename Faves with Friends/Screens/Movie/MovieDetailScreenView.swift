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
    
    
	// MARK: SwiftUI View
    var body: some View {
		GeometryReader { geometry in
			VStack {
				if let movie = movie {
					ZStack(alignment: .top) {
						VStack(alignment: .leading) {
							MovieDetailHeaderView(movie: movie, previewBackdropPhase: previewBackdropPhase, previewPosterPhase: previewPosterPhase)
								.edgesIgnoringSafeArea(.top)
								.frame(height: geometry.size.height / 4)
						}
					}
				}
				
				Form {
					Text("Form test")
				}
			}
        }
        .onAppear() {
			if movie == nil {
				getMovieDetails(id: id)
			}
        }
    }
	
	
	// MARK: Init
	
	init(id: Int, previewBackdropPhase: AsyncImagePhase? = nil, previewPosterPhase: AsyncImagePhase? = nil) {
		self.id = id
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
		MovieDetailScreenView(id: 11)
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}

