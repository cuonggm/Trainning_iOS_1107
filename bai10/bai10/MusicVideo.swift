//
//  MusicVideo.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/20/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class MusicVideo {
    var kind: String?
    var artistId: Int?
    var trackId: Int?
    var artistName: String?
    var trackName: String?
    var trackCensoredName: String?
    var artistViewUrl: String?
    var trackViewUrl: String?
    var previewUrl: String?
    var artworkUrl30: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var collectionPrice: Float?
    var trackPrice: Float?
    var releaseDate: String?
    var collectionExplicitness: String?
    var trackExplicitness: String?
    var trackTimeMillis: Int?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    
    static func getItems(json: [String: Any]) -> [MusicVideo] {
        
        var results = [MusicVideo]()
        let count = json["resultCount"] as! Int
        if count <= 0 {
            return results
        }
        let resultsArray = json["results"] as! [[String: Any]]
        for i in 0..<count {
            
            let musicVideo = MusicVideo()
            let item = resultsArray[i]
            
            musicVideo.kind = item["kind"] as? String
            musicVideo.artistId = item["artistId"] as? Int
            musicVideo.trackId = item["trackId"] as? Int
            musicVideo.artistName = item["artistName"] as? String
            musicVideo.trackName = item["trackName"] as? String
            musicVideo.trackCensoredName = item["trackCensoredName"] as? String
            musicVideo.artistViewUrl = item["artistViewUrl"] as? String
            musicVideo.trackViewUrl = item["trackViewUrl"] as? String
            musicVideo.previewUrl = item["previewUrl"] as? String
            musicVideo.artworkUrl30 = item["artworkUrl30"] as? String
            musicVideo.artworkUrl60 = item["artworkUrl60"] as? String
            musicVideo.artworkUrl100 = item["artworkUrl100"] as? String
            musicVideo.collectionPrice = item["collectionPrice"] as? Float
            musicVideo.trackPrice = item["trackPrice"] as? Float
            musicVideo.releaseDate = item["releaseDate"] as? String
            musicVideo.collectionExplicitness = item["collectionExplicitness"] as? String
            musicVideo.trackExplicitness = item["trackExplicitness"] as? String
            musicVideo.trackTimeMillis = item["trackTimeMillis"] as? Int
            musicVideo.country = item["country"] as? String
            musicVideo.currency = item["currency"] as? String
            musicVideo.primaryGenreName = item["primaryGenreName"] as? String
            
            results.append(musicVideo)
        }
        return results
    }

}
