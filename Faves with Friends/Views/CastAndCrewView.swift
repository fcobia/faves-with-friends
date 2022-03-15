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
    @State private var credits: CastAndCrewEntries?
    
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
                            ForEach(credits.cast.removeDuplicates(keyPath: \.id), id: \.id) { cast in
                                NavigationLink(destination: { destination(for: type, cast: cast) }) {
                                    VStack {
                                        ImageLoadingView(
                                            url: cast.image,
                                            style: .localProgress,
                                            progressViewSize: Constants.imageSize) { image in
                                                image.resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
                                            }
                                        Text(cast.name ?? "")
                                        Text(cast.character ?? "")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 15)
//
//                    Text("Crew")
//                    ScrollView(.horizontal, showsIndicators: true) {
//                        LazyHStack {
//                            ForEach(credits.crew.removeDuplicates(keyPath: \.id), id: \.id) { crew in
//                                NavigationLink(destination: { destination(for: type, cast: crew) }) {
//                                    VStack {
//                                        ImageLoadingView(
//                                            url: crew.image,
//                                            style: .localProgress,
//                                            progressViewSize: Constants.imageSize) { image in
//                                                image.resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
//                                            }
//                                        Text(crew.name ?? "")
//                                        Text(crew.job ?? "")
//                                    }
//                                }
//                            }
//                        }
//                    }
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
                    let data = try await environmentManager.movieNetworkManager.movieCredits(id: id)
                    credits = CastAndCrewEntries(data)
                    
                case .tv:
                    let data = try await environmentManager.movieNetworkManager.tvCredits(id: id)
                    credits = CastAndCrewEntries(data)
                    
                case .personMovie:
                    let data = try await environmentManager.movieNetworkManager.peopleMovieCredits(id: id)
                    credits = CastAndCrewEntries(data)
                    
                case .personTV:
                    let data = try await environmentManager.movieNetworkManager.peopleTVCredits(id: id)
                    credits = CastAndCrewEntries(data)
                    
                    //					case .personCombined:
                    //						let data = try await environmentManager.movieNetworkManager.peopleCombinedCredits(id: id)
                    //						credits = CastAndCrewEntries(data)
                }
            }
            catch let error {
                print("Got error fetching cast: \(error)")
                alertManager.showAlert(for: error)
                credits = CastAndCrewEntries()
            }
        }
    }
    
    // MARK: Private Methods
    private func destination(for creditsType: CreditsType, cast: CreditEntry ) -> some View {
        switch creditsType {
            
        case .movie:
            return AnyView(PersonDetailScreenView(id: cast.id, title: cast.name ?? ""))
            
        case .tv:
            return AnyView(PersonDetailScreenView(id: cast.id, title: cast.name ?? ""))
            
        case .personTV:
            return AnyView(TVDetailScreenView(id: cast.id, title: cast.name ?? ""))
            
        case .personMovie:
            return AnyView(MovieDetailScreenView(id: cast.id, movieTitle: cast.name ?? ""))
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
        case personMovie
        case personTV
        //case personCombined
    }
}

private struct CastAndCrewEntries {
    let cast: [CastCreditEntry]
    //let crew: [CrewCreditEntry]
    
    init() {
        self.cast = []
        //self.crew = []
    }
    
    init(_ data: Credits) {
        self.cast = data.cast
        //self.crew = data.crew
    }
    
    init(_ data: PersonCredits) {
        self.cast = data.cast
        //self.crew = data.crew
    }
}


// MARK: - Preview
//struct CastAndCrewView_Previews: PreviewProvider {
//    static var previews: some View {
//        CastAndCrewView()
//    }
//}
