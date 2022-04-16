//
//  WatchingListScreenRowView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 1/23/22.
//

import SwiftUI

struct WatchingListScreenRowView: View {
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
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(role: .destructive) {
                    favesViewModel.removeFromWatchingList(watchListItem)
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
                } else if watchListItem.type == .tv {
                    tv = try await environmentManager.movieNetworkManager.tvDetails(id: id)
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


//struct WatchingListScreenRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchingListScreenRowView()
//    }
//}
