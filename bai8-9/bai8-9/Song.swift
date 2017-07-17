//
//  Song.swift
//  bai8-9
//
//  Created by Cuong Giap Minh on 7/17/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class Song {
    
    var trackName: String!
    var artistName: String!
    var artworkUrl100: String!
    var trackPrice: String!
    var releaseDate: String!
    var collectionName: String!
 
    init(trackName: String, artistName: String, artworkUrl100: String, trackPrice: String, releaseDate: String, collectionName: String) {
        
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.collectionName = collectionName
    }
}
