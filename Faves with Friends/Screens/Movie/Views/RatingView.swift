//
//  RatingView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/3/21.
//

import SwiftUI

struct RatingView: View {
    
    enum Ratings: Double {
        case Abysmal = 0.0
        case Awful = 0.5
        case Bad = 1.0
        case Poor = 1.5
        case Medicore = 2.0
        case Fair = 2.5
        case Good = 3.0
        case Great = 3.5
        case Excellent = 4.0
        case Amazin = 4.5
        case Phenomenal = 5.0
    }
    
    @Binding var rating: Double
    
    @State private var starSize: CGSize = .zero
    
    var label = "My Rating"
    var maximumRating = 5
    
    var fullStar: some View {
        Image(systemName: "star.fill")
            .star(size: starSize)
            .foregroundColor(Color.yellow)
    }
    
    var halfStar: some View {
        Image(systemName: "star.leadinghalf.fill")
            .star(size: starSize)
            .foregroundColor(Color.yellow)
    }
    
    var emptyStar: some View {
        Image(systemName: "star")
            .star(size: starSize)
            .foregroundColor(Color.gray)
    }
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            if label.isEmpty == false {
                Text(label)
            }
            ZStack {
                HStack {
                    ForEach(0..<Int(rating), id: \.self) { _ in
                        fullStar
                    }
                    
                    if (rating != floor(rating)) {
                        halfStar
                    }
                    
                    ForEach(0..<Int(Double(maximumRating) - rating), id: \.self) { _ in
                        emptyStar
                    }
                }
                .onPreferenceChange(StarSizeKey.self) { size in
                    starSize = size
                }
                
                HStack {
                    ForEach(0..<maximumRating, id: \.self) { idx in
                        Color.clear
                            .frame(width: starSize.width, height: starSize.height)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if idx == 0 {
                                    if rating == 1 {
                                        rating = 0.5
                                    } else if rating == 0.5 {
                                        rating = 0
                                    } else {
                                        rating = 1
                                    }
                                } else {
                                    let i = Double(idx) + 1
                                    rating = (rating == i) ? i - 0.5 : i
                                }
                            }
                    }
                }
            }
        }
    }
}

fileprivate extension Image {
    func star(size: CGSize) -> some View {
        return self
            .font(.title)
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: StarSizeKey.self, value: proxy.size)
                }
            )
            .frame(width: size.width, height: size.height)
    }
}

struct StarSizeKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let next = nextValue()
        value = CGSize(width: max(value.width, next.width), height: max(value.height, next.height))
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
