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
	
	// MARK: State Variables
	@State private var person: Person? = nil

	// MARK: Private Variables
	private let id: Int
	private let title: String

	
	// MARK: SwiftUI View
    var body: some View {
		ScrollView(.vertical, showsIndicators: true) {
			if let person = person {
				VStack(alignment: .leading, spacing: 30) {
					HStack {
						Text("Name: ")
						Text(person.name)
					}
					
					VStack(alignment: .center, spacing: 5) {
						Text("Movie Cast & Crew")
						CastAndCrewView(type: .personMovie, id: id)
					}
					
					VStack(alignment: .center, spacing: 5) {
						Text("TV Cast & Crew")
						CastAndCrewView(type: .personTV, id: id)
					}
					
					VStack(alignment: .center, spacing: 5) {
						Text("Combined Cast & Crew")
						CastAndCrewView(type: .personCombined, id: id)
					}
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
