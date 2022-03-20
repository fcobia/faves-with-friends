//
//  FavesViewModel.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/3/21.
//

import Foundation

class FaveViewModel: ObservableObject {
    
    
    @Published var toWatchList = [WatchListItem]() {
        didSet {
            //first turn the array into nsdata so we can save it in userdefaults
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(toWatchList)
                UserDefaults.standard.set(data, forKey: "ToWatchList")
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
                UserDefaults.standard.set(data, forKey: "WatchedList")
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
                UserDefaults.standard.set(data, forKey: "WatchingList")
            } catch {
                print("could not encode for some reason")
            }
        }
    }
    
    
    //TODO: will need to check if movie is already in list and if so remove it and add new entry as rating may have changed?
    func addToToWatchList(_ watchListItem: WatchListItem) {
        //make sure not already in list and if not add it
        if toWatchList.firstIndex(where: { $0.videoId == watchListItem.videoId }) == nil {
            toWatchList.append(watchListItem)
        }
        //remove from other list now
        removeFromWatchingList(watchListItem)
    }
    
    func addToWatchedList(_ watchListItem: WatchListItem) {
        //make sure not already in list and if not add it
        if watchedList.firstIndex(where: { $0.videoId == watchListItem.videoId }) == nil {
            watchedList.append(watchListItem)
        }
        //remove from other list
        removeFromWatchingList(watchListItem)
    }
    
    func addToWatchingList(_ watchListItem: WatchListItem) {
        //make sure not already in list and if not add it
        if watchingList.firstIndex(where: { $0.videoId == watchListItem.videoId }) == nil {
            watchingList.append(watchListItem)
        }
        //remove from other list
        removeFromToWatchList(watchListItem)
    }
    
    func removeFromToWatchList(_ watchListItem: WatchListItem) {
        if let videoIndex = toWatchList.firstIndex(where: { $0.videoId == watchListItem.videoId }) {
            toWatchList.remove(at: videoIndex)
        }
    }
    
    func removeFromWatchedList(_ watchListItem: WatchListItem) {
        if let videoIndex = watchedList.firstIndex(where: { $0.videoId == watchListItem.videoId }) {
            watchedList.remove(at: videoIndex)
        }
    }
    
    func removeFromWatchingList(_ watchListItem: WatchListItem) {
        if let videoIndex = watchingList.firstIndex(where: { $0.videoId == watchListItem.videoId }) {
            watchingList.remove(at: videoIndex)
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "ToWatchList") {
            let decoder = JSONDecoder()
            do {
                let toWatchList = try decoder.decode([WatchListItem].self, from: data)
                self.toWatchList = toWatchList
            } catch {
                print("error decoding array")
            }
        } else {
            toWatchList = [WatchListItem]()
        }
        if let data = UserDefaults.standard.data(forKey: "WatchedList") {
            let decoder = JSONDecoder()
            do {
                let watchedList = try decoder.decode([WatchListItem].self, from: data)
                self.watchedList = watchedList
            } catch {
                print("error decoding array")
            }
        } else {
            watchedList = [WatchListItem]()
        }
        if let data = UserDefaults.standard.data(forKey: "WatchingList") {
            let decoder = JSONDecoder()
            do {
                let watchingList = try decoder.decode([WatchListItem].self, from: data)
                self.watchingList = watchingList
            } catch {
                print("error decoding array")
            }
        } else {
            watchingList = [WatchListItem]()
        }

    }
    
}

struct WatchListItem: Codable, Identifiable {
    var id = UUID()
    let videoId: Int
    let rating: Double?
    let type: VideoType?
    let title: String?
    let moviePosterURL: URL?
    let list: String
}
