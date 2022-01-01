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
    @EnvironmentObject var favesViewModel: FaveViewModel
    
    
    var body: some View {
        List {
            ForEach(favesViewModel.toWatchList, id: \.id) { watchListItem in
                NavigationLink(destination: { destination(for: watchListItem) }) {
                    MyListScreenRowView(watchListItem: watchListItem)
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .navigationTitle("My List")
    }
    
    // MARK: Private Methods
    private func destination(for video: WatchListItem) -> some View {
        switch video.type {
            
        case .movie:
            return AnyView(MovieDetailScreenView(id: video.videoId, movieTitle: video.title ?? "Unknown"))
            
        case .tv:
            return AnyView(EmptyView())
            
        case .none:
            return AnyView(EmptyView())
        }
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListScreenView()
    }
}
