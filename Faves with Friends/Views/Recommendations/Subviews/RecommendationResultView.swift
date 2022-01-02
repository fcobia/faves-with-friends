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
			
			ImageLoadingView(url: searchResult.image, style: .localProgress, progressViewSize: Constants.imageSize) { image in
				image.resizable()
					 .aspectRatio(contentMode: .fit)
					 .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
			}

			VStack(alignment: .leading) {
				Text(searchResult.name)
				
				if let video = searchResult as? Video, let releaseDate = video.releaseDate {
					Text(DateFormatters.dateOnly.string(from: releaseDate))
						.font(.footnote)
				}
			}
			
			Spacer()
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
