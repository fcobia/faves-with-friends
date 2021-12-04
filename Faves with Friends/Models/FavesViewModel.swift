//
//  FavesViewModel.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 12/3/21.
//

import Foundation

class FaveViewModel: ObservableObject {
    
    @Published var toWatchList = [Movie]() {
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
    @Published var watchedList = [Movie]() {
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
    
    func addToToWatchList(movie: Movie) {
        toWatchList.append(movie)
    }
    
    func addToWatchedList(movie: Movie) {
        watchedList.append(movie)
        
    }
    
}
