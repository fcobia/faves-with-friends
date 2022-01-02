//
//  TVDetailScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import SwiftUI


struct TVDetailScreenView: View {
	
	// MARK: Private Variables
	private let id: Int
	private let title: String

	
	// MARK: SwiftUI View
    var body: some View {
		VStack(alignment: .leading) {
			RecommendedTVView(tvId: id)
		}
		.navigationTitle(title)
		.navigationBarTitleDisplayMode(.inline)
    }
	
	
	// MARK: Init
	init(id: Int, title: String) {
		self.id = id
		self.title = title
	}
}


// MARK: - Preview
//struct TVDetailScreenViewView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVDetailScreenView()
//    }
//}
