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

	
	// MARK: Environment Variables
	@Environment(\.showModal) var showModal
	@Environment(\.dismiss) var dismiss
	@Environment(\.preferredPalettes) var pallet

    // MARK: Private Variables
    private let searchResult: SearchResult
	
	// MARK: Stats Variables
	@State private var showMovieDetails = false
    
    
    // MARK: SwiftUI View
    var body: some View {
        VStack {
			contentView()
				.toolbar {
					if showModal.wrappedValue {
						Button("Close") {
							showModal.wrappedValue = false
						}
						.foregroundColor(pallet.color.alternativeText)
					}
				}

			Spacer()
        }
		.sheet(isPresented: $showMovieDetails) {
			NavigationView {
				destinationView()
			}
			.environment(\.showModal, $showMovieDetails)
		}
    }
    
    // MARK: Private Methods
	private func contentView() -> some View {
		Group {
			if showModal.wrappedValue {
				NavigationLink(destination: {
					destinationView()
				}) {
					searchResultView()
				}
			}
			else {
				Button {
					showMovieDetails = true
				} label: {
					searchResultView()
				}
			}
		}
	}
	
	private func searchResultView() -> some View {
		ImageLoadingView(url: searchResult.image, style: .localProgress, progressViewSize: Constants.imageSize) { image in
			image.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
		}
	}
	
    private func destinationView() -> some View {
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
