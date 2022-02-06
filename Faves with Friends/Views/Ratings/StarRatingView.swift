//
//  StarRatingView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/5/22.
//

import SwiftUI


struct StarRatingView: View {
	
	// MARK: Private Init Variables
	private let count: Int
	private let size: CGFloat
	private let spacing: CGFloat
	private let scaling: CGFloat
	
	// MARK: Private Variables
	private let coordinateSpaceName = UUID().uuidString
	private let locations: [(CGFloat, CGFloat, CGFloat)]

	// MARK: Binding Variables
	@Binding private var rating: Double?

	// MARK: State Variables
	@State private var currentRating: Double	= 0
	@State private var currentScale: CGFloat	= 1

	
	// MARK: SwiftUI
    var body: some View {
		
		VStack(spacing: 3) {
			Text(RatingName.name(for: currentRating))
				.font(.title)

			StarsView(count: count, size: size, spacing: spacing, rating: currentRating)
				.coordinateSpace(name: coordinateSpaceName)
				.gesture(
					DragGesture(minimumDistance: 0, coordinateSpace: .named(coordinateSpaceName))
						.onChanged({ value in
							currentRating = calculateNewRating(value.location.x)
							currentScale = scaling
						})
						.onEnded({ value in
							rating = currentRating
							currentScale = 1
						})
				)
		}
		.scaleEffect(currentScale)
    }
	
	
	// MARK: Init
	init(_ rating: Binding<Double?>, count: Int = 5, size: CGFloat = 25, spacing: CGFloat = 5, scaling: CGFloat = 1) {
		self._rating = rating
		self.currentRating = rating.wrappedValue ?? 0

		self.count = count
		self.size = size
		self.spacing = spacing
		self.scaling = scaling
		
		self.locations = StarRatingView.calculateLocations(count: count, size: size, spacing: spacing)
	}
	
	
	// MARK: Private Calculation Functions
	
	private static func calculateLocations(count: Int, size: CGFloat, spacing: CGFloat) -> [(CGFloat, CGFloat, CGFloat)] {
		var result: [(CGFloat, CGFloat, CGFloat)] = []
		
		let halfSpace = spacing / 2
		let halfStar = size / 2
		let lastI = count - 1
		
		var lastStart: CGFloat = 0
		for i in 0..<count {
			let startSpace = i == 0 ? 0 : halfSpace
			
			let start = lastStart
			
			let end = start + startSpace + size + (i != lastI ? halfSpace : 0 )
			let mid = start + startSpace + halfStar
			
			result.append((start, mid, end))
			lastStart = end
		}
		
		return result
	}
	
	private func calculateNewRating(_ x: CGFloat) -> Double {
		let locations = locations
		
		let offset = x

		var index: Int?
		for i in 0..<locations.count {
			let currentLocation = locations[i]
			
			if offset >= currentLocation.0 && offset <= currentLocation.2 {
				index = i
				break
			}
		}
		
		if let index = index {
			if offset < locations[index].1 {
				return Double(index) + 0.5
			}
			else {
				return Double(index + 1)
			}
		}
		else if offset < 0 {
			return 0
		}
		else {
			return Double(count)
		}
	}
}


// MARK: Rating Names
enum RatingName: Double, CaseIterable {
	case Abysmal = 0.0
	case Awful = 0.5
	case Bad = 1.0
	case Poor = 1.5
	case Medicore = 2.0
	case Fair = 2.5
	case Good = 3.0
	case Great = 3.5
	case Excellent = 4.0
	case Amazing = 4.5
	case Phenomenal = 5.0
	
	static func name(for rating: Double) -> String {
		let ratings = RatingName.allCases
		
		var result: RatingName = ratings[0]
		for ratingEntry in ratings {
			result = ratingEntry
			if rating <= result.rawValue {
				break
			}
		}
		
		return String(describing: result)
	}
}



// MARK: - Preview
struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			StarRatingView(.constant(3.5))
		}
		.previewLayout(.sizeThatFits)
    }
}
