//
//  MainView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct MainView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager

	
	// MARK: SwiftUI
	var body: some View {
		Group {
			
			// Have we finished launching
			TabView {
				
				// Tab 1
				NavigationView {
					Text("Search")
				}
				.tabItem {
					Image(systemName: "magnifyingglass.circle")
                    Text("Search")
				}
				
				// Tab 2
				NavigationView {
					Text("My List")
				}
				.tabItem {
					Image(systemName: "list.bullet.circle")
                    Text("My List")
				}
                
                NavigationView {
                    Text("Your Ratings")
                }
                .tabItem {
                    Image(systemName: "star.circle")
                    Text("My Ratings")
                }
                
                NavigationView {
                    Text("Inbox")
                }
                .tabItem {
                    Image(systemName: "tray.circle")
                    Text("Inbox")
                }
                
                NavigationView {
                    Text("Profile")
                }
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
			}
			.navigationViewStyle(.stack)
		}
		.onAppear {
			DispatchQueue.main.async {
				alertManager.showAlert(for: TestError.test)
			}
		}
	}
}

enum TestError: Error {
	case test
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
