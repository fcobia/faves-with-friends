//
//  WatchListItem.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 4/8/22.
//

import Foundation


struct WatchListItem: Codable, Identifiable {
	
	// MARK: JSON Variables
	let id: String
	let dateAdded: Date
	let videoId: Int
	let type: VideoType
	let title: String?
	let rating: Double?
	
	
	// MARK: Init
	init(videoId: Int, type: VideoType, title: String?, rating: Double? = nil) {
		self.id = UUID().uuidString
		self.dateAdded = Date()
		self.videoId = videoId
		self.type = type
		self.title = title
		self.rating = rating
	}
	
	init(watchListItem item: WatchListItem) {
		self.init(videoId: item.videoId, type: item.type, title: item.title, rating: item.rating)
	}
}


extension WatchListItem {
	
	init<T: Video>(video: T, rating: Double? = nil) {
		self.init(videoId: video.id, type: video.type, title: video.title, rating: rating)
	}
	
	init?(searchResult: SearchResult, rating: Double? = nil) {
		
		// Determint he type
		let videoType: VideoType
		switch searchResult.type {
				
			case .person:
				return nil
				
			case .tv:
				videoType = .tv
				
			case .movie:
				videoType = .movie
		}
		
		// Finish
		self.init(videoId: searchResult.id, type: videoType, title: searchResult.name, rating: rating)
	}
}
