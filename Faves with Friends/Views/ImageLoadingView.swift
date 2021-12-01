//
//  ImageLoadingView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/30/21.
//

import SwiftUI


struct ImageLoadingView<Content>: View where Content: View {
	
	// MARK: Preview Support Variables
	private let previewPhase: AsyncImagePhase?

	// MARK: URL
	private let url: URL?
	private let progressViewSize: CGSize
	private let content: (Image) -> Content


	// MARK: SwiftUI View
    var body: some View {
		
		if let previewPhase = previewPhase {
			view(for: previewPhase)
		}
		else {
			AsyncImage(url: url) { phase in
				view(for: phase)
			}
		}
    }
	
	
	// MARK: Private Methods
	
	private func view(for phase: AsyncImagePhase) -> some View {
		switch phase {
				
			case .empty:
				return AnyView(LoadingView(backgroundSize: progressViewSize))
				
			case .success(let image):
				return AnyView(content(image))
				
			case .failure:
				return AnyView(FailureView())
				
			@unknown default:
				// Since the AsyncImagePhase enum isn't frozen,
				// we need to add this currently unused fallback
				// to handle any new cases that might be added
				// in the future:
				return AnyView(EmptyView())
			}
	}
	
	
	// MARK: Init
	
	init(url: URL?, progressViewSize: CGSize = .init(width: 100, height: 100), previewPhase: AsyncImagePhase? = nil, @ViewBuilder content: @escaping (Image) -> Content) {
		self.url = url
		self.progressViewSize = progressViewSize
		self.content = content
		
		self.previewPhase = previewPhase
	}
}


// MARK: Private View Classes
private struct LoadingView: View {
	
	// Variables
	let backgroundSize: CGSize
	
	
	// MARK: SwiftUI View
	var body: some View {
		VStack {
			HStack {
				ProgressView()
			}
		}
	}
}


private struct FailureView: View {
	
	// MARK: SwiftUI View
	var body: some View {
		Image(systemName: "photo")
			.frame(width: .infinity, height: 300)
	}
}


// MARK: - Preview
struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			
			ImageLoadingView(url: URL(string: "https://www.test.com")!, previewPhase: .success(Image("MovieBackdrop"))) { image in
				image
			}
			
			Group {

				LoadingView(backgroundSize: .init(width: 100, height: 100))
					.previewDisplayName("Loading")
				
				FailureView()
					.previewDisplayName("Failure")
			}
			.frame(width: 300, height: 300)
			.previewLayout(.sizeThatFits)
		}
    }
}
