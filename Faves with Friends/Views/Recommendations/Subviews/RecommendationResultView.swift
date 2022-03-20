//
//  RecommendationResultView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import SwiftUI


struct RecommendationResultView: View {
    
    // MARK: Constants
    private enum Constants {
        static let imageSize = CGSize(width: 75, height: 100)
    }
    
    // Private Variables
    private let searchResult: SearchResult
    
    
    // MARK: SwiftUI View
    var body: some View {
        VStack {
            NavigationLink(destination: { destination(for: searchResult) }) {
                ImageLoadingView(url: searchResult.image, style: .localProgress, progressViewSize: Constants.imageSize) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
                }
            }
            .listRowBackground(Color.clear)

			Spacer()
        }
    }
    
    // MARK: Private Methods
    private func destination(for searchResult: SearchResult) -> some View {
        switch searchResult.type {
            
        case .movie:
            return AnyView(MovieDetailScreenView(id: searchResult.id, movieTitle: searchResult.name))
            
        case .tv:
            return AnyView(TVDetailScreenView(id: searchResult.id, title: searchResult.name))
            
        case .person:
            return AnyView(EmptyView())
        }
    }
    
    // MARK: Init
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
}


// MARK: - Preview
//struct RecommendationResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendationResultView()
//    }
//}
