//
//  Media.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/9/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

class MediaCollection {
    
    // MARK: Variables

    var items = [MPMediaItem]()
    var count: Int {
        return items.count
    }
    
    // MARK: Methods
    
    // load songs from library
    func loadSongs() {
        items = []
        let query = MPMediaQuery.songs()
        if let _items = query.items {
            items = _items
        }
    }
    
    // return a MPMediaItem
    func getItem(at index: Int) -> MPMediaItem {
        return items[index]
    }
    
}
