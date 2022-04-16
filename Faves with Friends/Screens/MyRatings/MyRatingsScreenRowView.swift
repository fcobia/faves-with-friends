//
//  MyRatingsScreenRowView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/23/21.
//

import SwiftUI

struct MyRatingsScreenRowView: View {
    // MARK: Constants
    private enum Constants {
        static let imageSize = CGSize(width: 75, height: 100)
    }
    
    // MARK: Preview Support Variables
    let previewImagePhase: AsyncImagePhase?
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FavesManager
    
    @State private var rating: Double?
    
    let watchListItem: WatchListItem
    
    @State private var video: Movie?
    @State private var tv: TV?
    
    var body: some View {
        HStack {
            if watchListItem.type == .movie {
                ImageLoadingView(url: video?.posterPath, style: .localProgress, progressViewSize: Constants.imageSize, previewPhase: previewImagePhase) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
                }
            } else if watchListItem.type == .tv {
                ImageLoadingView(url: tv?.posterPath, style: .localProgress, progressViewSize: Constants.imageSize, previewPhase: previewImagePhase) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
                }
            }
           
            
            VStack(alignment: .leading) {
                if watchListItem.type == .movie {
                    Text(video?.title ?? "")
                } else if watchListItem.type == .tv {
                    Text(tv?.title ?? "")
                }
                
                if watchListItem.type == .movie {
                    if let releaseDate = video?.releaseDate {
                        Text(DateFormatters.dateOnly.string(from: releaseDate))
                            .font(.footnote)
                    }
                } else if watchListItem.type == .tv {
                    if let releaseDate = tv?.releaseDate {
                        Text(DateFormatters.dateOnly.string(from: releaseDate))
                            .font(.footnote)
                    }
                }
                
                StarRatingView($rating, size: 16, showText: false)
                    .allowsHitTesting(false)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(role: .destructive) {
                    favesViewModel.removeFromWatchedList(watchListItem)
                } label: {
                    VStack {
                        Image(systemName: "minus.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        Text("Remove")
                            .font(.caption)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 20)
            }
        }
        .onAppear {
            getMovieDetails(id: watchListItem.videoId)
        }
    }
    
    // MARK: Private Methods
    private func getMovieDetails(id: Int) {
        Task {
            do {
                activityManager.showActivity()
                if watchListItem.type == .movie {
                    video = try await environmentManager.movieNetworkManager.movieDetails(id: id)
                    if let video = video {
                        rating = favesViewModel.find(video: video)?.item.rating
                    }
                } else if watchListItem.type == .tv {
                    tv = try await environmentManager.movieNetworkManager.tvDetails(id: id)
                    if let video = tv {
                        rating = favesViewModel.find(video: video)?.item.rating
                    }
                }
            }
            catch let error {
                print("Error: \(error)")
                alertManager.showAlert(for: error)
            }
            
            activityManager.hideActivity()
        }
    }
}
//struct MyRatingsScreenRowview_Previews: PreviewProvider {
//    static var previews: some View {
//        MyRatingsScreenRowview()
//    }
//}
