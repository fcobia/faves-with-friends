//
//  PersonDetailScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import SwiftUI


struct PersonDetailScreenView: View {
    
    // MARK: Environment Variables
    @Environment(\.environmentManager) private var environmentManager: EnvironmentManager
    @Environment(\.preferredPalettes) var palettes
    
    // MARK: EnvironmentObjects
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var activityManager: ActivityManager
    
    // MARK: Constants
    private enum Constants {
        static let imageSize = CGSize(width: 150, height: 200)
    }
    
    // MARK: State Variables
    @State private var person: Person? = nil
    
    // MARK: Private Variables
    private let id: Int
    private let title: String
    
    let dateFormatter = DateFormatter()
    
    // MARK: SwiftUI View
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            if let person = person {
                VStack(alignment: .leading, spacing: 30) {
                    HStack(alignment: .center) {
                        
                        Spacer()
                        ImageLoadingView(
                            url: person.profilePath,
                            style: .localProgress,
                            progressViewSize: Constants.imageSize) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: Constants.imageSize.width, maxHeight: Constants.imageSize.height)
                            }
                        Spacer()
                        
                    }
                    .padding(5)
                    HStack(alignment: .top) {
                        ZStack(alignment: .leading) {
                            Text("Biography: ")
                                .opacity(0)
                                .accessibility(hidden: true)
                            Text("Name: ")
                        }
                        Text(person.name)
                    }
                    .padding(5)
                    HStack(alignment: .top) {
                        ZStack(alignment: .leading) {
                            Text("Biography: ")
                                .opacity(0)
                                .accessibility(hidden: true)
                            Text("Born: ")
                        }
                        if let dob = person.birthday {
                            Text(dateFormatter.string(from: dob))
                        }
                    }
                    .padding(.leading, 5)
                    .onAppear {
                        dateFormatter.dateStyle = .medium
                    }
                    HStack(alignment: .top) {
                        Text("Biography: ")
                        ScrollView {
                            Text(person.biography ?? "")
                        }
                        .frame(width: 300, height: 200, alignment: .leading)
                    }
                    .padding(5)
                    Divider()
                    VStack(alignment: .center, spacing: 5) {
                        Text("Movie Cast & Crew")
                            .bold()
                        CastAndCrewView(type: .personMovie, id: id)
                    }
                    Divider()
                    VStack(alignment: .center, spacing: 5) {
                        Text("TV Cast & Crew")
                            .bold()
                        CastAndCrewView(type: .personTV, id: id)
                    }
                    .padding(.bottom)
//                    Divider()
//                    VStack(alignment: .center, spacing: 5) {
//                        Text("Combined Cast & Crew")
//                            .bold()
//                        CastAndCrewView(type: .personCombined, id: id)
//                    }
//                    .padding(.bottom)
                }
            }
            else {
                Text("")
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                activityManager.showActivity()
                person = try await environmentManager.movieNetworkManager.peopleDetails(id: id)
            }
            catch let error {
                print("Error: \(error)")
                alertManager.showAlert(for: error)
            }
            
            activityManager.hideActivity()
        }
    }
    
    
    // MARK: Init
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}


// MARK: - Preview
//struct PersonDetailScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonDetailScreenView()
//    }
//}
