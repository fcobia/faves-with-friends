//
//  ImageLoadingView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/30/21.
//

import SwiftUI


struct ImageLoadingView<Content>: View where Content: View {
	
	// MARK Style Enum
	enum Style {
		case placeholder(Image?)
		case localProgress
		case globalProgress
	}
	
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var activityManager: ActivityManager

	// MARK: Preview Support Variables
	private let previewPhase: AsyncImagePhase?

	// MARK: URL
	private let style: Style
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
				return AnyView(LocalLoadingView(backgroundSize: progressViewSize))
				
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
	
	private func loadingView() -> some View {
		switch style {
				
			case .placeholder(let placeholder):
				return AnyView(placeholderLoadingView(placeholder ?? Image(systemName: "photo")))
				
			case .localProgress:
				return AnyView(LocalLoadingView(backgroundSize: progressViewSize))
				
			case .globalProgress:
				return AnyView(showGlobalLoadingView())
		}
	}
				 
	private func placeholderLoadingView(_ image: Image) -> some View {
		image
			.resizable()
	}
	
	private func showGlobalLoadingView() -> some View {
		Task {
			activityManager.showActivity()
		}
		
		return EmptyView()
	}
	
	private func hideGlobalLoadingView() {
		if case .globalProgress = style {
			Task {
				activityManager.hideActivity()
			}
		}
	}

	
	// MARK: Init
	
	init(url: URL?, style: Style = .localProgress, progressViewSize: CGSize = .init(width: 100, height: 100), previewPhase: AsyncImagePhase? = nil, @ViewBuilder content: @escaping (Image) -> Content) {
		self.url = url
		self.progressViewSize = progressViewSize
		self.content = content
		
		self.style = style
		self.previewPhase = previewPhase
	}
}


// MARK: Private View Classes
private struct LocalLoadingView: View {
	
	// Variables
	let backgroundSize: CGSize
	
	
	// MARK: SwiftUI View
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				ProgressView()
					.tint(.white)
					.scaleEffect(1.5)
				Spacer()
			}
			Spacer()
		}
		.background(Color.black.opacity(0.3))
	}
}


private struct FailureView: View {
	
	// MARK: SwiftUI View
	var body: some View {
		Image(systemName: "photo")
			.resizable()
	}
}


// MARK: - Preview
struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			
			ImageLoadingView(url: URL(string: "https://www.test.com")!, previewPhase: .success(Image("PreviewMovieBackdrop"))) { image in
				image
			}
			
			Group {

				LocalLoadingView(backgroundSize: .init(width: 100, height: 100))
					.previewDisplayName("Loading")
				
				FailureView()
					.previewDisplayName("Failure")
			}
			.frame(width: 300, height: 300)
			.previewLayout(.sizeThatFits)
		}
    }
}
