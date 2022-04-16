//
//  ListType.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 3/14/22.
//

import Foundation

enum ListType: String {
    case toWatch
    case watched
    case watching
    
    var id: String {
        self.rawValue
    }
    
    var displayName: String {
        var title: String = "To Watch"
        if self == .toWatch {
            title = "To Watch"
        } else if self == .watched {
            title = "Watched"
        } else if self == .watching {
            title = "Watching"
        }
        return title
    }
}
