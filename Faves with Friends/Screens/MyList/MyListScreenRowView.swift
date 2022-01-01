//
//  MyListScreenRowView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/23/21.
//

import SwiftUI

struct MyListScreenRowView: View {

    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FaveViewModel
    
    let watchListItem: WatchListItem
    
    @State private var video: Movie?
    
    var body: some View {
        Text(video?.title ?? "")
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
