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
    @EnvironmentObject var favesViewModel: FavesManager
    
    // MARK: Private State Variables
    @State private var list: ListType? = nil
    @State private var rating: Double?
    @State private var showingAlert = false
    @State private var showRecommended = false
	
	// MARK: Computed Variables
	private var watched: Bool {
		list == .watched
	}

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
                
                HStack {
                    VStack {
                        StarRatingView($rating, size: 26, showText: false)
                        
                        if showModal.wrappedValue {
                            showWatchListButton()
                            if searchResult.type == .movie {
                                NavigationLink(destination: RecommendedMoviesView(movieId: searchResult.id).navigationTitle("Recommended"), isActive: $showRecommended) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                            } else if searchResult.type == .tv {
                                NavigationLink(destination: RecommendedTVView(tvId: searchResult.id).navigationTitle("Recommended"), isActive: $showRecommended) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        else {
                            showWatchListButton()
                                .sheet(isPresented: $showRecommended) {
                                    if searchResult.type == .movie {
                                        NavigationView {
                                            RecommendedMoviesViewVertical(movieId: searchResult.id)
                                                .navigationTitle("Recommended")
                                                .navigationBarTitleDisplayMode(.inline)
                                        }
                                        .environment(\.showModal, $showRecommended)
                                    } else if searchResult.type == .tv {
                                        NavigationView {
                                            RecommendedTVViewVertical(tvId: searchResult.id)
                                                .navigationTitle("Recommended")
                                                .navigationBarTitleDisplayMode(.inline)
                                        }
                                        .environment(\.showModal, $showRecommended)
                                    }
                                }
                        }
                    }
                    
                    if list == .none || list == .watched {
                        HStack {
                            Spacer()
                            
                            Button {
                                list = .toWatch
                                favesViewModel.addToToWatchList(searchResult)
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
            .padding(.top, 3)
            .alert("Added to Watch List", isPresented: $showingAlert) {}
            
            Spacer()
        }
        .onChange(of: rating, perform: { newValue in
			favesViewModel.updateRating(for: searchResult, rating: newValue)
			list = favesViewModel.list(for: searchResult)
        })
        .task {
			if let findResult = favesViewModel.find(searchResult: searchResult) {
				rating = findResult.item.rating
				list = findResult.listType
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
            if searchResult.type == .movie {
                Text("Similar Movies")
            } else if searchResult.type == .tv {
                Text("Similar Shows")
            }
        }
        .rowViewButton()
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
