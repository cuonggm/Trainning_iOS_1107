//
//  ItuneConnection.swift
//  bai8-9
//
//  Created by Cuong Giap Minh on 7/17/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class ItuneConnection {
    
    static let defaultConnection: ItuneConnection = ItuneConnection()
    
    private init() {}
    
    func searchSongs(searchString: String, complete: @escaping (Song)-> Void) {
        
        let term = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://itunes.apple.com/search?media=music&term=\(term ?? "")")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, respond, error) in
            if error == nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    let count = dict["resultCount"] as! Float
                    let resultsArray = dict["results"] as! [[String: Any]]
                    for i in 0...(resultsArray.count-1) {
                        
                        let song = resultsArray[i]
                        let trackName = song["trackName"] as? String
                        let artistName = song["artistName"] as? String
                        let artworkUrl100 = song["artworkUrl100"] as? String
                        let trackPrice = song["trackPrice"] as? Double
                        let releaseDate = song["releaseDate"] as? String
                        let collectionName = song["collectionName"] as? String
                        
                        let songObject = Song(trackName: trackName ?? "", artistName: artistName ?? "", artworkUrl100: artworkUrl100 ?? "", trackPrice: String(trackPrice ?? 0.0), releaseDate: releaseDate ?? "", collectionName: collectionName ?? "")
                            complete(songObject)
                            NotificationCenter.default.post(name: NSNotification.Name(keyForProgress), object: self, userInfo: ["progress": Float(i+1)/count])
                    }
                    
                } catch {}
            }
        }
        
        task.resume()
    }
}
