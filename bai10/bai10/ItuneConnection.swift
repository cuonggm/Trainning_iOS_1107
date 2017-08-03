//
//  ItuneConnection.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/19/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class ItuneConnection {
    
    static let defaultConnection: ItuneConnection = ItuneConnection()
    
    private init() {}
    
    func search(term: String, media: String, complete: @escaping ([String: Any])-> Void) {
        
        let _term = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let _media = media.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://itunes.apple.com/search?media=\(_media ?? "")&term=\(_term ?? "")")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, respond, error) in
            if error == nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                        complete(dict)
                } catch {}
            }
        }
        
        task.resume()
    }
    
}
