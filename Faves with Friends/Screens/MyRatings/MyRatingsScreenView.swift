//
//  MyRatingsScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/23/21.
//

import SwiftUI

struct MyRatingsScreenView: View {
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    @EnvironmentObject var favesViewModel: FaveViewModel
    
    
    var body: some View {
        List {
            ForEach(favesViewModel.watchedList, id: \.id) { watchListItem in
                NavigationLink(destination: { destination(for: watchListItem) }) {
                    MyRatingsScreenRowView(watchListItem: watchListItem)
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .navigationTitle("My Ratings")
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

struct MyRatingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyRatingsScreenView()
    }
}
