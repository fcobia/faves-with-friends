//
//  MyListScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/23/21.
//

import SwiftUI

struct MyListScreenView: View {
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FavesManager
    
    
    var body: some View {
        List {
            ForEach(favesViewModel.allToWatch, id: \.id) { watchListItem in
                NavigationLink(destination: { destination(for: watchListItem) }) {
                    MyListScreenRowView(previewImagePhase: nil,  watchListItem: watchListItem)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        favesViewModel.removeFromToWatchList(watchListItem)
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
            }   
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
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

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListScreenView()
    }
}
