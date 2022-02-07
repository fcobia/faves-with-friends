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
        case MyRatingsScreenView = "MyRatingsScreenView"
        
        var id: String {
            self.rawValue
        }
    }
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    @Environment(\.preferredPalettes) var palettes
    
    @State private var listView: ListViews = .MyListScreenView
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Picker("", selection: $listView) {
                        ForEach(ListViews.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(palettes.color.primary).opacity(0.8).cornerRadius(8.0)
                    .padding(.bottom)
                    .onChange(of: listView) { value in
                        switch value {
                        case .MyListScreenView:
                            listView = .MyListScreenView
                        case .MyRatingsScreenView:
                            listView = .MyRatingsScreenView
                        }
                    }
                }
                .padding()
            }
            if listView == .MyListScreenView {
                MyListScreenView()
            } else if listView == .MyRatingsScreenView {
                MyRatingsScreenView()
            }
        }
    }
}

struct ListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreenView()
    }
}
