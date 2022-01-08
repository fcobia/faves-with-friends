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
    
    
    //TODO: will need to check if movie is already in list and if so remove it and add new entry as rating may have changed?
    func addToToWatchList(_ watchListItem: WatchListItem) {
        toWatchList.append(watchListItem)
    }
    
    func addToWatchedList(_ watchListItem: WatchListItem) {
        watchedList.append(watchListItem)
        
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
    }
    
}

struct WatchListItem: Codable, Identifiable {
    var id = UUID()
    let videoId: Int
    let rating: Double?
    let type: VideoType?
    let title: String?
    let moviePosterURL: URL?
}
