//
//  MyListScreenRowView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/23/21.
//

import SwiftUI

struct MyListScreenRowView: View {

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
    @EnvironmentObject var favesViewModel: FaveViewModel
    
    let watchListItem: WatchListItem
    
    @State private var video: Movie?
    
    var body: some View {
        HStack {
            ImageLoadingView(url: video?.posterPath, style: .localProgress, progressViewSize: Constants.imageSize, previewPhase: previewImagePhase) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
            }
            
            VStack(alignment: .leading) {
                Text(video?.title ?? "")
                
                if let releaseDate = video?.releaseDate {
                    Text(DateFormatters.dateOnly.string(from: releaseDate))
                        .font(.footnote)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(role: .destructive) {
                    favesViewModel.removeFromToWatchList(watchListItem)
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
                video = try await environmentManager.movieNetworkManager.movieDetails(id: id)
            }
            catch let error {
                print("Error: \(error)")
                alertManager.showAlert(for: error)
            }
            
            activityManager.hideActivity()
        }
    }
}

//struct MyListScreenRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyListScreenRowView(watchListItem: WatchListItem(videoId: 500, rating: nil, type: nil))
//    }
//}
