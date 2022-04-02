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
	
	// MARK: Environment Variables
	@Environment(\.showModal) var showModal

    // MARK: EnvironmentObjects
    @EnvironmentObject var favesViewModel: FaveViewModel
    
    // MARK: Private State Variables
    @State private var list: ListType? = nil
    @State private var rating: Double?
    @State private var watched = false
    @State private var showingAlert = false
	@State private var showRecommended = false

    // MARK: Preview Support Variables
    private let previewImagePhase: AsyncImagePhase?
    
    // Init Variables
    private let searchResult: SearchResult
    
    
    // MARK: SwiftUI View
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            
            ImageLoadingView(url: searchResult.image, style: .localProgress, progressViewSize: Constants.imageSize, previewPhase: previewImagePhase) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
            }
            
            VStack(alignment: .leading) {
                
                VStack {
                    HStack {
                        Text(searchResult.name)
                            .fontWeight(.bold)
                            .appText()
                        Spacer()
                    }
                    HStack {
                        if let video = searchResult as? Video, let releaseDate = video.releaseDate {
                            Text(DateFormatters.dateOnly.string(from: releaseDate))
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                
                if searchResult.type == .movie {
                    HStack {
                        VStack {
							StarRatingView($rating, size: 26, showText: false)
							
							if showModal.wrappedValue {
								showWatchListButton()
								
								NavigationLink(destination: RecommendedMoviesView(movieId: searchResult.id).navigationTitle("Recommended"), isActive: $showRecommended) {
									EmptyView()
								}
                                .opacity(0.0)
                                   .buttonStyle(PlainButtonStyle())
							}
							else {
								showWatchListButton()
									.sheet(isPresented: $showRecommended) {
										NavigationView {
											RecommendedMoviesViewVertical(movieId: searchResult.id)
												.navigationTitle("Recommended")
												.navigationBarTitleDisplayMode(.inline)
										}
										.environment(\.showModal, $showRecommended)
									}
							}
                        }
						
						if list == .none || list == .Watched {
							HStack {
								Spacer()
								
								Button {
									list = .Watchlist
									favesViewModel.addToToWatchList(createWatchListItem(searchResult))
									showingAlert = true
									DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
										showingAlert = false
									}
								} label: {
									Image(systemName: "text.badge.plus")
										.font(.largeTitle)
								}
								.buttonStyle(PlainButtonStyle())
								
								Spacer()
							}
						}
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(.top, 3)
			.alert("Added to Watch List", isPresented: $showingAlert) {}

            Spacer()
        }
        .onChange(of: rating, perform: { newValue in
            if searchResult.type == .movie, let index = favesViewModel.watchedList.firstIndex(where: { $0.videoId == searchResult.id }) {
                list = .Watched
                favesViewModel.watchedList[index] = createWatchListItem(searchResult)
            }
            else {
                list = .Watched
                favesViewModel.addToWatchedList(createWatchListItem(searchResult))
            }
        })
        .task {
            if searchResult.type == .movie {
                if let index = favesViewModel.watchedList.firstIndex(where: { $0.videoId == searchResult.id }) {
                    rating = favesViewModel.watchedList[index].rating
                    let listString = favesViewModel.watchedList[index].list
                    list = ListType(rawValue: listString)
                    watched = true
                }
                
                if let index = favesViewModel.toWatchList.firstIndex(where: { $0.videoId == searchResult.id }) {
                    let listString = favesViewModel.toWatchList[index].list
                    list = ListType(rawValue: listString)
                }
                
                if let index = favesViewModel.watchingList.firstIndex(where: { $0.videoId == searchResult.id }) {
                    let listString = favesViewModel.watchingList[index].list
                    list = ListType(rawValue: listString)
                }
            }
        }
    }
    
    
    // MARK: Init
    init(searchResult: SearchResult, previewImagePhase: AsyncImagePhase? = nil) {
        self.searchResult = searchResult
        self.previewImagePhase = previewImagePhase
    }
    
    
    // MARK: Private Methods
	private func showWatchListButton() -> some View {
		Button {
			showRecommended = true
		} label: {
			Text("Similar Movies")
		}
		.rowViewButton()
	}
    
    private func createWatchListItem(_ movie: SearchResult) -> WatchListItem {
        .init(videoId: movie.id, rating: rating, type: .movie, title: movie.name, moviePosterURL: movie.image, list: list?.rawValue ?? "")
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
