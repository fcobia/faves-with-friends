//
//  RecommendedMoviesViewVertical.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 4/2/22.
//

import SwiftUI

struct RecommendedMoviesViewVertical: View {
    
    // MARK: Environment Variables
    
    // MARK: Environment Variables
    @Environment(\.showModal) var showModal
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    @Environment(\.preferredPalettes) var pallet

    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager

    // MARK: Private Observable Objects
    @StateObject private var dataSource         = MovieRecommendationsDataSource()
    @StateObject private var activityManager    = ActivityManager()

    //MARK: Private Variables
    private let movieId: Int
    
    
    // MARK: SwiftUI
    var body: some View {
        
        Group {
            
                SearchListView(dataSource: dataSource, fetchesOnLoad: true)
                    .toolbar {
                        Button("Close") {
                            showModal.wrappedValue = false
                        }
                        .foregroundColor(pallet.color.alternativeText)
                    }
            
      
        }
        .onAppear {
            dataSource.inject(movieId: movieId)
        }
    }
    
    
    // MARK: Init
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    
    // MARK: Private Methods
    private func scrollView(_ results: [SearchResult]) -> some View {
        Group {
            
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack {
                        forEachView(results)
                    }
                }
        }
    }
    
    private func forEachView(_ results: [SearchResult]) -> some View {
        ForEach(results, id: \.equalityId) { searchResult in
            contentView(searchResult: searchResult)
                .onAppear {
                    dataSource.fetchIfNecessary(searchResult)
                }
        }
    }
    
    private func contentView(searchResult: SearchResult) -> some View {
        RecommendationResultView(searchResult: searchResult)
    }
}
