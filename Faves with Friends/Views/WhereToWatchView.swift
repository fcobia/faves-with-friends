//
//  WhereToWatchView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/29/22.
//

import SwiftUI


struct WhereToWatchView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager

	// MARK: Constants
	private enum Constants {
		static let imageSize = CGSize(width: 50, height: 50)
	}

	// MARK: State Variables
	@State private var whereToWatchResult: WhereToWatch??
	
	// MARK: Init Variables
	private let type: WhereToWatchType
	private let id: Int

	
	// MARK: SwiftUI View
    var body: some View {
		Group {
			if let result = whereToWatchResult {
				if let whereToWatch = result, whereToWatch.flatRate != nil || whereToWatch.rent != nil || whereToWatch.buy != nil {
						
					VStack {
						if let entries = whereToWatch.flatRate {
							entriesView(link: whereToWatch.link, title: "Streaming", entries: entries)
						}
						
						if let entries = whereToWatch.rent {
							entriesView(link: whereToWatch.link, title: "Rent", entries: entries)
						}
						
						if let entries = whereToWatch.buy {
							entriesView(link: whereToWatch.link, title: "Buy", entries: entries)
						}
					}
                    HStack {
                        Image("JustWatch")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 50)
                        Link("Information provided by JustWatch, tap here for more info...", destination: URL(string: "https://www.justwatch.com")!)
                        .foregroundColor(.blue)
                        
                    }

				}
				else {
					EmptyView()
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
						whereToWatchResult = try await environmentManager.movieNetworkManager.movieWhereToWatch(id: id)
					case .tv:
						whereToWatchResult = try await environmentManager.movieNetworkManager.tvWhereToWatch(id: id)
				}
			}
			catch let error {
				print("Got error fetching where to watch \(error)")
				whereToWatchResult = nil
			}
		}
    }
	
	
	// MARK: Init
	init(type: WhereToWatchType, id: Int) {
		self.type = type
		self.id = id
	}

	
	// MARK: Private Functions
	
	private func entriesView(link: URL, title: String, entries: [WhereToWatchEntry]) -> some View {
		VStack {
			Text(title)
			
			ScrollView(.horizontal, showsIndicators: true) {
				HStack {
					Link(destination: link) {
						ForEach(entries, id: \.providerId) { entry in
							ImageLoadingView(
								url: entry.logoPath,
								style: .localProgress,
								progressViewSize: Constants.imageSize) { image in
									image.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
								}
						}
					}
				}
			}
		}
	}
}


extension WhereToWatchView {
	
	enum WhereToWatchType {
		case movie
		case tv
	}
}


// MARK: - Preview
//struct WhereToWatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhereToWatchView()
//    }
//}
