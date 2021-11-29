//
//  CurvedHeaderView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/28/21.
//

import SwiftUI


struct CurvedHeaderView<Content>: View where Content: View {

	// MARK: State Variables
	@State var maxContentHeight: CGFloat = 0

	// MARK: Private Variables
	private let id = UUID().uuidString
	private let content: () -> Content

	
	// MARK: SwiftUI
	var body: some View {
		ZStack {
			GeometryReader { geometry in

				HeaderShape(frame: geometry.frame(in: .local), maxHeight: maxContentHeight)
					.fill(.blue)
					.coordinateSpace(name: id)
					.ignoresSafeArea(edges: .top)
				
				content()
					.background(GeometryReader { geometry in
						Rectangle()
							.fill(Color.clear)
							.preference(key: MaxHeightPreferenceKey.self, value: geometry.frame(in: .named(id)).maxY)
					})
			}
		}
		.onPreferenceChange(MaxHeightPreferenceKey.self) { maxHeight in
			self.maxContentHeight = maxHeight
		}
	}
	
	
	// MARK: Init
	
	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content
	}
}


private struct HeaderShape : Shape {
	let frame: CGRect
	let maxHeight: CGFloat
	
	func path(in rect: CGRect) -> Path {
		print("Frame: \(frame)")
		print("Max Height: \(maxHeight)")
		
		let minX = frame.minX
		let midX = frame.width / 2
		let maxX = frame.maxX
		let minY = frame.minY
		let maxY = maxHeight
		
		var path = Path()
		
		path.move(to: CGPoint(x: minX, y: maxY))
		path.addLine(to: CGPoint(x: minX, y: minY))
		path.addLine(to: CGPoint(x: maxX, y: minY))
		path.addLine(to: CGPoint(x: maxX, y: maxY))
		path.addQuadCurve(to: CGPoint(x: minX, y: maxY), control: CGPoint(x: midX, y: maxY + 25))

		return path
	}
}

private struct MaxHeightPreferenceKey: PreferenceKey {
	static var defaultValue: CGFloat = 0

	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		let next = nextValue()
		
		if next > value {
			value = next
		}
	}
}
