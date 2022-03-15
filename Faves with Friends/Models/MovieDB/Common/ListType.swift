//
//  ListType.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 3/14/22.
//

import Foundation

enum ListType: String {
    case Watchlist
    case Watched
    case Watching
    
    var id: String {
        self.rawValue
    }
    
    var displayName: String {
        var title: String = "To Watch"
        if self == .Watchlist {
            title = "To Watch"
        } else if self == .Watched {
            title = "Watched"
        } else if self == .Watching {
            title = "Watching"
        }
        return title
    }
}
