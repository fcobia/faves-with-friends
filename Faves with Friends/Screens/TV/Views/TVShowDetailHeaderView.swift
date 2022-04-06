//
//  TVShowDetailHeaderView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 4/5/22.
//


import SwiftUI

struct TVShowDetailHeaderView: View {
    
    // MARK: Preview Support Variables
    private let previewBackdropPhase: AsyncImagePhase?
    private let previewPosterPhase: AsyncImagePhase?

    // MARK: Private Variables
    private let tvShow: TV


    // MARK: SwiftUI View
    var body: some View {
        ZStack {
            GeometryReader { geometry in

                // Background
                ImageLoadingView(url: tvShow.backdropPath, style: .globalProgress, previewPhase: previewBackdropPhase) { image in
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
                        ImageLoadingView(url: tvShow.posterPath, style: .globalProgress, previewPhase: previewPosterPhase) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(height: geometry.size.height / 1.5)

                        // Movie Info
                        VStack(alignment: .leading) {
                            
                            Text(tvShow.title)
                                .foregroundColor(.white)
                            
                            if let releaseDate = tvShow.releaseDate {
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
    
    init(tvShow: TV, previewBackdropPhase: AsyncImagePhase? = nil, previewPosterPhase: AsyncImagePhase? = nil) {
        self.tvShow = tvShow
        self.previewBackdropPhase = previewBackdropPhase
        self.previewPosterPhase = previewPosterPhase
    }
}
