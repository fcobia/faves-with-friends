//
//  CastAndCrewView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/26/22.
//

import SwiftUI


struct CastAndCrewView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager

	// MARK: Constants
	private enum Constants {
		static let imageSize = CGSize(width: 75, height: 100)
	}

	// MARK: State Variables
	@State private var credits: Credits?
	
	// MARK: Init Variables
	private let type: CreditsType
	private let id: Int
	
	
	// MARK: SwiftUI View
    var body: some View {
		VStack {
			if let credits = credits {
				VStack {
					Text("Cast")
					ScrollView(.horizontal, showsIndicators: true) {
						LazyHStack {
							ForEach(credits.cast.withoutDuplicates) { cast in
								VStack {
									ImageLoadingView(
										url: cast.image,
										style: .localProgress,
										progressViewSize: Constants.imageSize) { image in
											image.resizable()
												.aspectRatio(contentMode: .fit)
												.frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
										}
									Text(cast.name)
								}
							}
						}
					}
					
					Spacer()
						.frame(height: 15)
					
					Text("Crew")
					ScrollView(.horizontal, showsIndicators: true) {
						LazyHStack {
							ForEach(credits.crew.withoutDuplicates) { crew in
								VStack {
									ImageLoadingView(
										url: crew.image,
										style: .localProgress,
										progressViewSize: Constants.imageSize) { image in
											image.resizable()
												.aspectRatio(contentMode: .fit)
												.frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
										}
									Text(crew.name)
								}
							}
						}
					}
				}
			}
			else {
				LoadingRowView()
			}
		}
		.task {
			do {
				switch type {
					case .movie:
						credits = try await environmentManager.movieNetworkManager.movieCredits(id: id)
					case .tv:
						credits = try await environmentManager.movieNetworkManager.tvCredits(id: id)
				}
			}
			catch let error {
				print("Got error fetching cast & crew: \(error)")
				alertManager.showAlert(for: error)
				credits = Credits(cast: [], crew: [])
			}
		}
    }
	
	
	// MARK: Init
	init(type: CreditsType, id: Int) {
		self.type = type
		self.id = id
	}
}


extension CastAndCrewView {
	
	enum CreditsType {
		case movie
		case tv
	}
}


// MARK: - Preview
//struct CastAndCrewView_Previews: PreviewProvider {
//    static var previews: some View {
//        CastAndCrewView()
//    }
//}
