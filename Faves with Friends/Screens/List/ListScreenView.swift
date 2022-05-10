//
//  ListScreenView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 2/6/22.
//

import SwiftUI

struct ListScreenView: View {
    enum ListViews: String, CaseIterable, Identifiable {
        case MyListScreenView = "MyListScreenView"
        case WatchingListScreenView = "WatchingListScreenView"
        case MyRatingsScreenView = "MyRatingsScreenView"
        
        var id: String {
            self.rawValue
        }
        
        var displayName: String {
            var title: String = "To Watch"
            if self == .MyListScreenView {
                title = "To Watch"
            } else if self == .MyRatingsScreenView {
                title = "Watched"
            } else if self == .WatchingListScreenView {
                title = "Watching"
            }
            return title
        }
    }
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    @Environment(\.preferredPalettes) var palettes
    
    @EnvironmentObject var favesViewModel: FavesManager
    
    @State private var listView: ListViews = .MyListScreenView
    @State private var count = 0
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("Total: \(count)")
                    .padding(.top, 10)
                HStack(alignment: .top) {
                    Picker("", selection: $listView) {
                        ForEach(ListViews.allCases) { type in
                            Text(type.displayName).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(palettes.color.primary).opacity(0.8).cornerRadius(8.0)
                    .onChange(of: listView) { value in
                        switch value {
                        case .MyListScreenView:
                            listView = .MyListScreenView
                            count = favesViewModel.allToWatch.count
                        case .MyRatingsScreenView:
                            listView = .MyRatingsScreenView
                            count = favesViewModel.allWatched.count
                        case .WatchingListScreenView:
                            listView = .WatchingListScreenView
                            count = favesViewModel.allWatching.count
                        }
                    }
                    .onAppear() {
                        switch listView {
                        case .MyListScreenView:
                            count = favesViewModel.allToWatch.count
                        case .MyRatingsScreenView:
                            count = favesViewModel.allWatched.count
                        case .WatchingListScreenView:
                            count = favesViewModel.allWatching.count
                        }
                    }
                }
            }
            if listView == .MyListScreenView {
                MyListScreenView()
            } else if listView == .MyRatingsScreenView {
                MyRatingsScreenView()
            } else if listView == .WatchingListScreenView {
                WatchingListScreenView()
            }
        }
    }
}

struct ListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreenView()
    }
}
