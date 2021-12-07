//
//  MovieDetailHeaderView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/30/21.
//

import SwiftUI


struct MovieDetailHeaderView: View {
	
	// MARK: Preview Support Variables
	private let previewBackdropPhase: AsyncImagePhase?
	private let previewPosterPhase: AsyncImagePhase?

	// MARK: Private Variables
	private let movie: Movie	


	// MARK: SwiftUI View
    var body: some View {
        ZStack {
			GeometryReader { geometry in

				// Background
				ImageLoadingView(url: movie.backdropPath, style: .globalProgress, previewPhase: previewBackdropPhase) { image in
					image.resizable()
						.scaledToFit()
						.overlay {
							Rectangle()
								.fill(Color.gray)
								.opacity(0.50)
						}
				}
				 
				// Movie Poster
                VStack {
                    Spacer()
					HStack {
						ImageLoadingView(url: movie.posterPath, style: .globalProgress, previewPhase: previewPosterPhase) { image in
							image
								.resizable()
								.scaledToFit()
						}
                        .frame(height: geometry.size.height / 1.5)

						// Movie Info
						VStack(alignment: .leading) {
							
							Text(movie.title)
								.foregroundColor(.white)
							
							if let releaseDate = movie.releaseDate {
								Text(DateFormatters.dateOnly.string(from: releaseDate))
									.font(.footnote)
									.foregroundColor(.white)
							}
						}
					}
                    .padding([.leading, .bottom, .top], 20)
                    Spacer()
				}
			}
		}
    }
	
	
	// MARK: Init
	
	init(movie: Movie, previewBackdropPhase: AsyncImagePhase? = nil, previewPosterPhase: AsyncImagePhase? = nil) {
		self.movie = movie
		self.previewBackdropPhase = previewBackdropPhase
		self.previewPosterPhase = previewPosterPhase
	}
}


// MARK: - Preview
struct MovieDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			
			MovieDetailHeaderView(
				movie: PreviewMovieNetworkManager.mockMovieDetails,
				previewBackdropPhase: .success(Image("PreviewMovieBackdrop")),
				previewPosterPhase: .success(Image("PreviewMoviePoster")))
			
			MovieDetailHeaderView(
				movie: PreviewMovieNetworkManager.mockMovieDetails,
				previewBackdropPhase: .success(Image("PreviewMovieBackdrop")),
				previewPosterPhase: .empty)
			
			MovieDetailHeaderView(
				movie: PreviewMovieNetworkManager.mockMovieDetails,
				previewBackdropPhase: .empty,
				previewPosterPhase: .success(Image("PreviewMoviePoster")))
		}
		.frame(maxHeight: 300)
		.previewLayout(.sizeThatFits)
    }
}
