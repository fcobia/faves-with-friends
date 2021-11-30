//
//  MovieDetailHeaderView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/30/21.
//

import SwiftUI


struct MovieDetailHeaderView: View {
	
	// MARK: Private Variables
	let image: Image
	

	// MARK: SwiftUI View
    var body: some View {
		image.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(maxWidth: .infinity, maxHeight: 300)
			.ignoresSafeArea()
			.overlay {
				Rectangle()
					.fill(Color.gray)
					.opacity(0.50)
					.frame(maxWidth: .infinity, maxHeight: 300)
					.ignoresSafeArea()
			}
    }
}


// MARK: - Preview
struct MovieDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
		MovieDetailHeaderView(image: Image("MovieBackdrop"))
    }
}
