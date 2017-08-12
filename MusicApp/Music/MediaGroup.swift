//
//  MediaAlbums.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/12/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

class MediaGroup {
    
    // MARK: Variables
    
    var items = [MPMediaItemCollection]()
    var count: Int {
        return items.count
    }
    
    // MARK: Methods
    
    // load albums from library
    
    func loadAlbums() {
        items = []
        let query = MPMediaQuery.albums()
        if let _items = query.collections {
            items = _items
        }
    }
    
    func loadArtists() {
        items = []
        let query = MPMediaQuery.artists()
        if let _items = query.collections {
            items = _items
        }
    }
    
    // return a MPMediaItem
    func getItem(at index: Int) -> MPMediaItemCollection {
        return items[index]
    }
    
    // search Album
    func searchAlbums(query: String) -> [MPMediaItemCollection] {
        var result = [MPMediaItemCollection]()
        let queryLowerCased = query.lowercased()
        for collection in items {
            if let item = collection.representativeItem {
                if let albumName = item.albumTitle?.lowercased() {
                    if albumName.contains(queryLowerCased) {
                        result.append(collection)
                    }
                }
                
            }
        }
        return result
    }
    
    func searchArtists(query: String) -> [MPMediaItemCollection] {
        var result = [MPMediaItemCollection]()
        let queryLowerCased = query.lowercased()
        for collection in items {
            if let item = collection.representativeItem {
                if let artistName = item.artist?.lowercased() {
                    if artistName.contains(queryLowerCased) {
                        result.append(collection)
                    }
                }
                
            }
        }
        return result
    }

}
