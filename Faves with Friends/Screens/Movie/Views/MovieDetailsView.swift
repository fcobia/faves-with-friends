//
//  MovieDetailsView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/2/21.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Title:")
                    .fontWeight(.semibold)
                    .appText()
                HStack {
                    Text(movie.title)
                        .font(.subheadline)
                        .appText()
                    Text("(movie)")
                        .font(.footnote)
                        .appText()
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Release Date:")
                    .fontWeight(.semibold)
                    .appText()
                Text(movie.releaseDate)
                    .font(.subheadline)
                    .appText()
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Runtime:")
                    .fontWeight(.semibold)
                    .appText()
                Text(String(movie.runtime) + " minutes")
                    .font(.subheadline)
                    .appText()
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Status:")
                    .fontWeight(.semibold)
                    .appText()
                Text(movie.status)
                    .font(.subheadline)
                    .appText()
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Overview:")
                    .fontWeight(.semibold)
                    .appText()
                Text(movie.overview)
                    .font(.subheadline)
                    .appText()
            }
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    ForEach(movie.genres) { genre in
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
        }
        .padding(.leading)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie.movieExample)
    }
}
