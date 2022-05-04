//
//  SearchScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/26/21.
//

import SwiftUI
import Combine


struct SearchScreenView: View {
    
	// MARK: Private StateObject Objects
	@StateObject private var dataSource 		= SearchResultsDataSource()

    @FocusState var isInputActive: Bool
    
	// MARK: SwiftUI
    var body: some View {
		VStack {
			CurvedHeaderView {
				VStack {
					VStack {
						Text("ShowZ")
							.font(.largeTitle.weight(.semibold))
							.appAltText()
					}
					
					TextField("Search", text: $dataSource.searchText)
						.appRoundedTextField()
                        .foregroundColor(.black)
						.modifier(ClearButtonModifier(text: $dataSource.searchText))
                        .onAppear {
                            UITextField.appearance().backgroundColor = .white
                        }
                        .focused($isInputActive)
                        .submitLabel(.done)
//                        .toolbar {
//                            ToolbarItemGroup(placement: .keyboard) {
//                                Spacer()
//                                Button("Done") {
//                                    isInputActive = false
//                                }
//                                .foregroundColor(.blue)
//                            }
//                        }
                        
                    
					Picker("", selection: $dataSource.searchType) {
						ForEach(SearchType.allCases) { type in
							Text(type.rawValue).tag(type)
						}
					}
					.pickerStyle(SegmentedPickerStyle())
					.background(Color(UIColor.systemBackground)).opacity(0.8).cornerRadius(8.0)
					.padding(.bottom)
//
//					Text("\(dataSource.totalResults) Results")
//						.font(.subheadline)
//						.foregroundColor(.white)
				}
				.padding([.horizontal, .bottom])
			}
			
			SearchListView(dataSource: dataSource, fetchesOnLoad: false)
		}
        .navigationBarHidden(true)
    }
}


// MARK: - Preview
struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
			.modifier(ContentView_Previews.previewEnvironmentModifier)
    }
}
