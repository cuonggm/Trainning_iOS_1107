//
//  Movie.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/24/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class Movie {
    var kind: String?
    var collectionId: Int?
    var trackId: Int?
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var artworkUrl100: String?
    var collectionPrice: Float?
    var trackPrice: Float?
    var trackRentalPrice: Float?
    var collectionHdPrice: Float?
    var trackHdPrice: Float?
    var trackHdRentalPrice: Float?
    var releaseDate: String?
    var discCount: Int?
    var discNumber: Int?
    var trackCount: Int?
    var trackNumber: Int?
    var shortDescription: String?
    var longDescription: String?
    var currency: String?
    var country: String?
    var previewUrl: String?
    
    static func getItems(json: [String: Any]) -> [Movie] {
        
        var results = [Movie]()
        let count = json["resultCount"] as! Int
        if count <= 0 {
            return results
        }
        let resultsArray = json["results"] as! [[String: Any]]
        for i in 0..<count {
            
            let movie = Movie()
            let item = resultsArray[i]
            
            movie.kind = item["kind"] as? String
            movie.collectionId = item["collectionId"] as? Int
            movie.trackId = item["trackId"] as? Int
            movie.artistName = item["artistName"] as? String
            movie.collectionName = item["collectionName"] as? String
            movie.trackName = item["trackName"] as? String
            movie.artworkUrl100 = item["artworkUrl100"] as? String
            movie.collectionPrice = item["collectionPrice"] as? Float
            movie.trackPrice = item["trackPrice"] as? Float
            movie.trackRentalPrice = item["trackRentalPrice"] as? Float
            movie.collectionHdPrice = item["collectionHdPrice"] as? Float
            movie.trackHdPrice = item["trackHdPrice"] as? Float
            movie.trackHdRentalPrice = item["trackHdRentalPrice"] as? Float
            movie.releaseDate = item["releaseDate"] as? String
            movie.discCount = item["discCount"] as? Int
            movie.discNumber = item["discNumber"] as? Int
            movie.trackCount = item["trackCount"] as? Int
            movie.trackNumber = item["trackNumber"] as? Int
            movie.shortDescription = item["shortDescription"] as? String
            movie.longDescription = item["longDescription"] as? String
            movie.currency = item["currency"] as? String
            movie.country = item["country"] as? String
            movie.previewUrl = item["previewUrl"] as? String
            
            results.append(movie)
        }
        return results
    }

}
