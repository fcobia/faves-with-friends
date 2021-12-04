//
//  RatingView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/3/21.
//

import SwiftUI

struct RatingView: View {
    
    enum Ratings: Int {
        case Abysmal = 0
        case Awful
        case Bad
        case Poor
        case Medicore
        case Fair
        case Good
        case Great
        case Excellent
        case Amazin
        case Phenomenal
    }
    
    @State private var rating: Ratings = .Medicore
    
    // to fill a star half way I can maybe set the foreground color of a star.fil to a grdient that is half yellow and half clear etc
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("My rating")
                .appText()
            HStack {
                ForEach((1...5), id: \.self) { index in
                    Image(systemName: index <= rating.rawValue ? "star.fill" : "star")
                        .font(.largeTitle)
                        .foregroundColor(index <= rating.rawValue ? Color.yellow : Color.gray)
                        .onTapGesture {
                            rating = Ratings(rawValue: index)!
                        }
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}



//Image(systemName: starOnFull == true ? "star.fill" : "star")
//    .font(.largeTitle)
//    .foregroundColor(starOnFull == true ? Color.yellow : Color.gray)
//    .onTapGesture {
//        starOnFull.toggle()
//}
//Image(systemName: starOnFull == true ? "star.fill" : "star")
//    .font(.largeTitle)
//    .foregroundColor(starOnFull == true ? Color.yellow : Color.gray)
//    .onTapGesture {
//        starOnFull.toggle()
//}
//Image(systemName: starOnFull == true ? "star.fill" : "star")
//    .font(.largeTitle)
//    .foregroundColor(starOnFull == true ? Color.yellow : Color.gray)
//    .onTapGesture {
//        starOnFull.toggle()
//}
//Image(systemName: starOnFull == true ? "star.fill" : "star")
//    .font(.largeTitle)
//    .foregroundColor(starOnFull == true ? Color.yellow : Color.gray)
//    .onTapGesture {
//        starOnFull.toggle()
//}
//Image(systemName: starOnFull == true ? "star.fill" : "star")
//    .font(.largeTitle)
//    .foregroundColor(starOnFull == true ? Color.yellow : Color.gray)
//    .onTapGesture {
//        starOnFull.toggle()
//}
