//
//  MovieCommon.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import Foundation

protocol MovieCommon {
    // MARK: JSON Variables
    var id: Int{ get set }
    var title: String { get set }
    var posterPathString: String? { get set }
    var releaseDate: String { get set }
}
