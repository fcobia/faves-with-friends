//
//  TVShowDetailsView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 4/5/22.
//

import SwiftUI

struct TVShowDetailsView: View {
    
    let tvShow: TV
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack {
                Text("Similar")
                    .bold()
                    .appText()
                RecommendedTVView(tvId: tvShow.id)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Title:")
                    .fontWeight(.semibold)
                    .appText()
                
                HStack {
                    Text(tvShow.title)
                        .font(.subheadline)
                        .appText()
                    Text("(TV Show)")
                        .font(.footnote)
                        .appText()
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Release Date:")
                    .fontWeight(.semibold)
                    .appText()
                
                if let releaseDate = tvShow.releaseDate {
                    Text(DateFormatters.dateOnly.string(from: releaseDate))
                        .font(.subheadline)
                        .appText()
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Number of seasons:")
                    .fontWeight(.semibold)
                    .appText()
                
                if let numSeasons = tvShow.numberOfSeasons {
                    Text(String(numSeasons))
                        .font(.subheadline)
                        .appText()
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("In Production:")
                    .fontWeight(.semibold)
                    .appText()
                
                Text(tvShow.inProduction ? "Yes" : "No")
                    .font(.subheadline)
                    .appText()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Overview:")
                    .fontWeight(.semibold)
                    .appText()
                
                if let overview = tvShow.overview {
                    Text(overview)
                        .font(.subheadline)
                        .appText()
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    ForEach(tvShow.genres) { genre in
                        Text(genre.name)
                            .font(.subheadline)
                            .appText()
                            .padding(.all, 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.gray)
                                    .opacity(0.30)
                            }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            
            Group {
                Divider()
                
                CastAndCrewView(type: .tv, id: tvShow.id)
                
                Divider()
                
                WhereToWatchView(type: .tv, id: tvShow.id)
            }
        }
        .padding([.leading, .bottom])
    }
}
