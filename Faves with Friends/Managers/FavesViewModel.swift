//
//  FavesViewModel.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/3/21.
//

import Foundation


class FavesManager: ObservableObject {
	private typealias ListAndIndex 	= (index: Int, listType: ListType, listKeyPath: KeyPath<FavesManager,[WatchListItem]>)
			typealias FindResult 	= (item: WatchListItem, listType: ListType)

	
	// MARK: Constants
	private enum Constants {
		static let toWatchListKey	= "ToWatchList"
		static let watchedListKey	= "WatchedList"
		static let watchingListKey	= "WatchingList"
	}
	
    
    // MARK: Published Variables
    @Published var toWatchList = [WatchListItem]() {
        didSet {
            //first turn the array into nsdata so we can save it in userdefaults
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(toWatchList)
				UserDefaults.standard.set(data, forKey: Constants.toWatchListKey)
            } catch {
                print("could not encode for some reason")
            }
        }
    }
    @Published var watchedList = [WatchListItem]() {
        didSet {
            //first turn the array into nsdata so we can save it in userdefaults
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(watchedList)
				UserDefaults.standard.set(data, forKey: Constants.watchedListKey)
            } catch {
                print("could not encode for some reason")
            }
        }
    }
    @Published var watchingList = [WatchListItem]() {
        didSet {
            //first turn the array into nsdata so we can save it in userdefaults
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(watchingList)
				UserDefaults.standard.set(data, forKey: Constants.watchingListKey)
            } catch {
                print("could not encode for some reason")
            }
        }
    }
	
	
	// MARK: - Init
	init() {
		if let data = UserDefaults.standard.data(forKey: Constants.toWatchListKey) {
			let decoder = JSONDecoder()
			do {
				let toWatchList = try decoder.decode([WatchListItem].self, from: data)
				self.toWatchList = toWatchList
			} catch {
				print("error decoding array")
			}
		}
		
		if let data = UserDefaults.standard.data(forKey: Constants.watchedListKey) {
			let decoder = JSONDecoder()
			do {
				let watchedList = try decoder.decode([WatchListItem].self, from: data)
				self.watchedList = watchedList
			} catch {
				print("error decoding array")
			}
		}
		
		if let data = UserDefaults.standard.data(forKey: Constants.watchingListKey) {
			let decoder = JSONDecoder()
			do {
				let watchingList = try decoder.decode([WatchListItem].self, from: data)
				self.watchingList = watchingList
			} catch {
				print("error decoding array")
			}
		}
	}

	
	// MARK: Private Common Methods
	private func listAndIndexFor(videoId: Int, type: VideoType) -> ListAndIndex? {
		
		// Check the toWatchList
		if let index = toWatchList.firstIndex(where: { $0.videoId == videoId && $0.type == type }) {
			return (index, .Watchlist, \.toWatchList)
		}
		
		// Check the watched list
		if let index = watchedList.firstIndex(where: { $0.videoId == videoId && $0.type == type }) {
			return (index, .Watched, \.watchedList)
		}
		
		// Check the watching list
		if let index = watchingList.firstIndex(where: { $0.videoId == videoId && $0.type == type }) {
			return (index, .Watching, \.watchingList)
		}
		
		return nil
	}
	
	private func remove(_ item: WatchListItem, from listKeyPath: WritableKeyPath<FavesManager, [WatchListItem]>, type: ListType) {
		
		// Make sure it is in the list
		guard let listAndIndex = listAndIndexFor(videoId: item.videoId, type: item.type), listAndIndex.listType == type else {
			return
		}
		
		// Remove it
		var localList = self[keyPath: listKeyPath]
		localList.remove(at: listAndIndex.index)
		var mutableSelf = self
		mutableSelf[keyPath: listKeyPath] = localList
	}
	
	private func add(_ item: WatchListItem, to listKeyPath: WritableKeyPath<FavesManager,[WatchListItem]>, type: ListType) {
		
		// Get a local copy of the list
		var localList = self[keyPath: listKeyPath]
		
		// Add or Update
		if let listAndIndex = listAndIndexFor(videoId: item.videoId, type: item.type), listAndIndex.listType == type {
			localList[listAndIndex.index] = item
		}
		else {
			localList.append(item)
		}
		
		// Save the changed list
		var writeableSelf = self
		writeableSelf[keyPath: listKeyPath] = localList
	}

	
	// MARK: - Locate Video
	func listFor(videoId: Int, type: VideoType) -> ListType? {
		listAndIndexFor(videoId: videoId, type: type)?.listType
	}
	
	func find(videoId: Int, type: VideoType) -> FindResult? {
		guard let listAndIndex = listAndIndexFor(videoId: videoId, type: type) else {
			return nil
		}
		
		let item = self[keyPath: listAndIndex.listKeyPath][listAndIndex.index]
		
		return (item, listAndIndex.listType)
	}
	
	
	// MARK: - Update the rating
	func updateRating(for item: WatchListItem) {
		
		// See if it is already in a list
		let listAndIndex: ListAndIndex
		if let currentListAndIndex = listAndIndexFor(videoId: item.videoId, type: item.type) {
			listAndIndex = currentListAndIndex
		}
		else {
			
			// Only if it has a rating
			guard item.rating != nil else {
				return
			}
			
			// Add to the watched list
			addToWatchedList(item)
			
			listAndIndex = (watchedList.count - 1, .Watched, \.watchedList)
		}
		
		// Figure out which list
		switch listAndIndex.listType {
				
			case .Watchlist:
				
				// Update or move to the watched list
				// Really it should already be nil, but we will be safe
				if let _ = item.rating {
					
					// Remove from the to watch
					var localToWatchList = toWatchList
					localToWatchList.remove(at: listAndIndex.index)
					
					// Add to the watched list
					var localWatchedList = watchedList
					localWatchedList.append(item)
					watchedList = localWatchedList
				}
				else {
					var localList = toWatchList
					localList[listAndIndex.index] = item
					toWatchList = localList
				}
				
			case .Watched:
				var localList = watchedList
				localList[listAndIndex.index] = item
				watchedList = localList
				
			case .Watching:
				
				// Update or move to the watched list
				// Really it should already be nil, but we will be safe
				if let _ = item.rating {
					
					// Remove from the to watch
					var localWatchingList = watchingList
					localWatchingList.remove(at: listAndIndex.index)
					
					// Add to the watched list
					var localWatchedList = watchedList
					localWatchedList.append(item)
					watchedList = localWatchedList
				}
				else {
					var localList = watchingList
					localList[listAndIndex.index] = item
					watchingList = localList
				}
		}
	}


	// MARK: - Watch List
    func addToToWatchList(_ watchListItem: WatchListItem) {
		add(watchListItem, to: \.toWatchList, type: .Watchlist)

		// Remove from other lists
        removeFromWatchingList(watchListItem)
		removeFromWatchedList(watchListItem)
    }
	
	func removeFromToWatchList(_ watchListItem: WatchListItem) {
		remove(watchListItem, from: \.toWatchList, type: .Watchlist)
	}

	
	// MARK: - Watched List
    func addToWatchedList(_ watchListItem: WatchListItem) {
		add(watchListItem, to: \.watchedList, type: .Watched)
		
		// Remove from other lists
		removeFromWatchingList(watchListItem)
		removeFromToWatchList(watchListItem)
    }
	
	func removeFromWatchedList(_ watchListItem: WatchListItem) {
		remove(watchListItem, from: \.watchedList, type: .Watched)
	}

	
	// MARK: - Watching List
    func addToWatchingList(_ watchListItem: WatchListItem) {
		add(watchListItem, to: \.watchingList, type: .Watching)
		
		// Remove from other lists
		removeFromToWatchList(watchListItem)
		removeFromWatchedList(watchListItem)
    }
    
    func removeFromWatchingList(_ watchListItem: WatchListItem) {
		remove(watchListItem, from: \.watchingList, type: .Watching)
    }
}


// MARK: - For Video
extension FavesManager {
	
	func list<T: Video>(for video: T) -> ListType? {
		listAndIndexFor(videoId: video.id, type: video.type)?.listType
	}
	
	func find<T: Video>(video: T) -> FindResult? {
		find(videoId: video.id, type: video.type)
	}
	
	func updateRating<T: Video>(for video: T, rating: Double?) {
		updateRating(for: .init(video: video, rating: rating))
	}

	func addToToWatchList<T: Video>(_ video: T, rating: Double? = nil) {
		addToWatchedList(.init(video: video, rating: rating))
	}
	
	func addToWatchedList<T: Video>(_ video: T, rating: Double? = nil) {
		addToWatchedList(.init(video: video, rating: rating))
	}
	
	func addToWatchingList<T: Video>(_ video: T, rating: Double? = nil) {
		addToWatchingList(.init(video: video, rating: rating))
	}
}



// MARK: - For SearchResult
extension FavesManager {
	
	func list(for searchResult: SearchResult) -> ListType? {
		
		// Get the type
		let type: VideoType
		switch searchResult.type {
			case .person:
				return nil
				
			case .tv:
				type = .tv
				
			case .movie:
				type = .movie
		}
		
		return listAndIndexFor(videoId: searchResult.id, type: type)?.listType
	}
	
	func find(searchResult: SearchResult) -> FindResult? {
		
		// Get the type
		let type: VideoType
		switch searchResult.type {
			case .person:
				return nil
				
			case .tv:
				type = .tv
				
			case .movie:
				type = .movie
		}

		return find(videoId: searchResult.id, type: type)
	}

	func updateRating(for searchResult: SearchResult, rating: Double?) {
		guard let item = WatchListItem(searchResult: searchResult, rating: rating) else {
			return
		}
		
		updateRating(for: item)
	}
	
	func addToToWatchList(_ searchResult: SearchResult, rating: Double? = nil) {
		guard let watchListItem = WatchListItem(searchResult: searchResult, rating: rating) else {
			return
		}
		
		addToWatchedList(watchListItem)
	}
	
	func addToWatchedList(_ searchResult: SearchResult, rating: Double? = nil) {
		guard let watchListItem = WatchListItem(searchResult: searchResult, rating: rating) else {
			return
		}
		
		addToWatchedList(watchListItem)
	}
	
	func addToWatchingList(_ searchResult: SearchResult, rating: Double? = nil) {
		guard let watchListItem = WatchListItem(searchResult: searchResult, rating: rating) else {
			return
		}
		
		addToWatchingList(watchListItem)
	}
}
