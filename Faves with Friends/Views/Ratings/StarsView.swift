//
//  StarsView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/5/22.
//

import SwiftUI


struct StarsView: View {
	
	// MARK: Private Variables
	private let count: Int
	private let size: CGFloat
	private let spacing: CGFloat
	private let rating: Double

	// MARK: Computed Values
	private var fullStar: some View { starImage("star.fill") }
	private var halfStar: some View { starImage("star.leadinghalf.fill") }
	private var emptyStar: some View { starImage("star") }

	
	// MARK: SwiftUI
    var body: some View {
		HStack(spacing: spacing) {
			ForEach(0..<count) { i in
				individualStar(rating, min: Double(i), max: Double(i + 1))
			}
		}
    }
	
	
	// MARK: Init
	init(count: Int = 5, size: CGFloat = 25, spacing: CGFloat = 5, rating: Double) {
		self.count = count
		self.size = size
		self.spacing = spacing
		self.rating = rating
	}

	
	// MARK: Private View Functions
	private func individualStar(_ rating: Double, min: Double, max: Double) -> some View {
		Group {
			if rating <= min {
				emptyStar
			}
			else if rating < max {
				halfStar
			}
			else {
				fullStar
			}
		}
	}
	
	private func starImage(_ name: String) -> some View {
		Image(systemName: name)
			.resizable()
			.frame(width: size, height: size)
			.foregroundColor(Color.yellow)
	}
}


// MARK: - Preview
struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			StarsView(rating: 0.5)
			StarsView(rating: 1)
			StarsView(rating: 1.5)
		}
		.previewLayout(.sizeThatFits)
    }
}
