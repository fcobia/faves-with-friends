//
//  SearchScreenRowView.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/27/21.
//

import SwiftUI

struct SearchScreenRowView: View {
    
    var movie: SimpleMovie
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: movie.posterPath) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 100, height: 100)
                            ProgressView()
                        }
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: 100, maxHeight: 100)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 100, height: 100)
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                    }
                }
                VStack(alignment: .leading) {
                    Text(movie.title)
                    Text(DateFormatters.dateOnly.string(from: movie.releaseDate))
                        .font(.footnote)
                }
            }
        }
    }
}

//struct SearchScreenRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchScreenRowView()
//    }
//}
