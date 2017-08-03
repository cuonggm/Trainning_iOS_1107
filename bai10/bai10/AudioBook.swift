//
//  AudioBook.swift
//  bai10
//
//  Created by Cuong Giap Minh on 8/3/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class AudioBook {
    var artistName: String?
    var collectionName: String?
    var artworkUrl100: String?
    var collectionPrice: Int?
    var trackCount: Int?
    var copyright: String?
    var country: String?
    var currency: String?
    var releaseDate: String?
    var previewUrl: String?
    
    static func getItems(json: [String: Any]) -> [AudioBook] {
        
        var results = [AudioBook]()
        let count = json["resultCount"] as! Int
        if count <= 0 {
            return results
        }
        let resultsArray = json["results"] as! [[String: Any]]
        for i in 0..<count {
            
            let audio = AudioBook()
            let item = resultsArray[i]
            
            audio.artistName = item["artistName"] as? String
            audio.collectionName = item["collectionName"] as? String
            audio.artworkUrl100 = item["artworkUrl100"] as? String
            audio.collectionPrice = item["collectionPrice"] as? Int
            audio.trackCount = item["trackCount"] as? Int
            audio.copyright = item["copyright"] as? String
            audio.country = item["country"] as? String
            audio.currency = item["currency"] as? String
            audio.releaseDate = item["releaseDate"] as? String
            audio.previewUrl = item["previewUrl"] as? String
            
            results.append(audio)
        }
        return results
    }
}
