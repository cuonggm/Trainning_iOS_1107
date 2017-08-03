//
//  Podcast.swift
//  bai10
//
//  Created by Cuong Giap Minh on 8/4/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class Podcast {
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var feedUrl: String?
    var artworkUrl100: String?
    var releaseDate: String?
    var trackCount: Int?
    var country: String?
    var currency: String?
    var artworkUrl600: String?
    
    static func getItems(json: [String: Any]) -> [Podcast] {
        
        var results = [Podcast]()
        let count = json["resultCount"] as! Int
        if count <= 0 {
            return results
        }
        let resultsArray = json["results"] as! [[String: Any]]
        for i in 0..<count {
            
            let podcast = Podcast()
            let item = resultsArray[i]
            
            podcast.artistName = item["artistName"] as? String
            podcast.collectionName = item["collectionName"] as? String
            podcast.trackName = item["trackName"] as? String
            podcast.feedUrl = item["feedUrl"] as? String
            podcast.artworkUrl100 = item["artworkUrl100"] as? String
            podcast.releaseDate = item["releaseDate"] as? String
            podcast.trackCount = item["trackCount"] as? Int
            podcast.country = item["country"] as? String
            podcast.currency = item["currency"] as? String
            podcast.artworkUrl600 = item["artworkUrl600"] as? String
            
            results.append(podcast)
        }
        return results
    }
}
