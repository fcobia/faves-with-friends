//
//  SearchScreenRowView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/27/21.
//

import SwiftUI


struct SearchScreenRowView: View {
	
	// MARK: Constants
	private enum Constants {
		static let imageSize = CGSize(width: 75, height: 100)
	}
	
	// MARK: Preview Support Variables
	private let previewImagePhase: AsyncImagePhase?

	// Init Variables
    private let searchResult: SearchResult
    
	
	// MARK: SwiftUI View
    var body: some View {
		HStack {
			
			ImageLoadingView(url: searchResult.image, style: .localProgress, progressViewSize: Constants.imageSize, previewPhase: previewImagePhase) { image in
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
	init(searchResult: SearchResult, previewImagePhase: AsyncImagePhase? = nil) {
		self.searchResult = searchResult
		self.previewImagePhase = previewImagePhase
	}
}


// MARK: - Preview
struct SearchScreenRowView_Previews: PreviewProvider {
    static var previews: some View {
		
		Group {
			
			SearchScreenRowView(
				searchResult: MockMultiSearchJSON.parsed().results.first!,
				previewImagePhase: .success(Image("PreviewMoviePoster")))
			
			SearchScreenRowView(
				searchResult: MockMultiSearchJSON.parsed().results.first!,
				previewImagePhase: .empty)
		}
		.frame(width: 360)
		.previewLayout(.sizeThatFits)
		.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
