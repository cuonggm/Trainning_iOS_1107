//
//  Ebook.swift
//  bai10
//
//  Created by Cuong Giap Minh on 8/3/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class Ebook {
    var artworkUrl100: String?
    var trackCensoredName: String?
    var fileSizeBytes: Int?
    var currency: String?
    var artistName: String?
    var genres: [String]?
    var price: Double?
    var description: String?
    var releaseDate: String?
    var averageUserRating: Double?
    var userRatingCount: Int?
    
    var genresString: String {
        if genres == nil {
            return ""
        }
        if genres?.count == 0 {
            return ""
        }
        
        var result = ""
        let count = genres!.count
        for i in 0..<count {
            result.append(genres![i])
            if i < count - 1 {
                result.append(", ")
            }
        }
        return result
    }
    
    
    
    static func getItems(json: [String: Any]) -> [Ebook] {
        
        var results = [Ebook]()
        let count = json["resultCount"] as! Int
        if count <= 0 {
            return results
        }
        let resultsArray = json["results"] as! [[String: Any]]
        for i in 0..<count {
            
            let ebook = Ebook()
            let item = resultsArray[i]
            
            ebook.artworkUrl100 = item["artworkUrl100"] as? String
            ebook.trackCensoredName = item["trackCensoredName"] as? String
            ebook.fileSizeBytes = item["fileSizeBytes"] as? Int
            ebook.currency = item["currency"] as? String
            ebook.artistName = item["artistName"] as? String
            ebook.genres = item["genres"] as? [String]
            ebook.price = item["price"] as? Double
            ebook.description = item["description"] as? String
            ebook.releaseDate = item["releaseDate"] as? String
            ebook.averageUserRating = item["averageUserRating"] as? Double
            ebook.userRatingCount = item["userRatingCount"] as? Int
            
            results.append(ebook)
        }
        return results
    }
}
