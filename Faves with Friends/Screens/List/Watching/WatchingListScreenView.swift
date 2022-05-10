//
//  WatchingListScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 1/23/22.
//

import SwiftUI

struct WatchingListScreenView: View {
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FavesManager
    
    
    var body: some View {
        List {
            ForEach(favesViewModel.allWatching, id: \.id) { watchListItem in
                NavigationLink(destination: { destination(for: watchListItem) }) {
                    WatchingListScreenRowView(previewImagePhase: nil,  watchListItem: watchListItem)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        favesViewModel.removeFromWatchingList(watchListItem)
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .padding(.top, 20)
        .navigationBarTitle(("Lists"), displayMode: .inline)
    }
    
    // MARK: Private Methods
    private func destination(for video: WatchListItem) -> some View {
        switch video.type {
            
        case .movie:
            return AnyView(MovieDetailScreenView(id: video.videoId, movieTitle: video.title ?? "Unknown"))
            
        case .tv:
            return AnyView(TVDetailScreenView(id: video.videoId, title: video.title ?? "Unknown"))
        }
    }
}

struct WatchingListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WatchingListScreenView()
    }
}
