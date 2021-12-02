//
//  CurvedHeaderView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/28/21.
//

import SwiftUI


struct CurvedHeaderView<Content>: View where Content: View {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	// MARK: State Variables
	@State var contentRect: CGRect = .zero

	// MARK: Private Variables
	private let bulgeHeight: CGFloat	= 25
	private let content: () -> Content

	
	// MARK: SwiftUI
	var body: some View {
		ZStack {
			
			HeaderShape(bulgeHeight: bulgeHeight)
				.fill(palettes.color.primary)
				.ignoresSafeArea(edges: .top)

			content()
				.background(GeometryReader { geometry in
					Rectangle()
						.fill(Color.clear)
						.preference(key: ContentPreferenceKey.self, value: geometry.frame(in: .global))
				})
		}
		.frame(height: contentRect.height)
		.onPreferenceChange(ContentPreferenceKey.self) { value in
//				DispatchQueue.main.async {
				self.contentRect = value
//				}
		}
	}
	
	
	// MARK: Init
	
	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content
	}
}


struct HeaderShape : Shape {
	let bulgeHeight: CGFloat

	func path(in rect: CGRect) -> Path {
		let minX = rect.minX
		let midX = rect.width / 2
		let maxX = rect.maxX
		let minY = rect.minY
		let maxY = rect.maxY - (bulgeHeight / 2)

		var path = Path()
		
		path.move(to: CGPoint(x: minX, y: maxY))
		path.addLine(to: CGPoint(x: minX, y: minY))
		path.addLine(to: CGPoint(x: maxX, y: minY))
		path.addLine(to: CGPoint(x: maxX, y: maxY))
		path.addQuadCurve(to: CGPoint(x: minX, y: maxY), control: CGPoint(x: midX, y: maxY + bulgeHeight))

		return path
	}
}

private struct ContentPreferenceKey: PreferenceKey {
	typealias Value = CGRect
	
	static var defaultValue: Value = .zero

	static func reduce(value: inout Value, nextValue: () -> Value) {
		let next = nextValue()
		
		if next != .zero {
			value = next
		}
	}
}
