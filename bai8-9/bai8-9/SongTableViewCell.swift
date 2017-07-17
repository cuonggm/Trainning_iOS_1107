//
//  SongTableViewCell.swift
//  bai8-9
//
//  Created by Cuong Giap Minh on 7/17/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameView: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    func bindData(song: Song) {
        DispatchQueue.main.async {
            self.trackNameLabel.text = song.trackName
            self.artistNameView.text = song.artistName
            self.trackPriceLabel.text = song.trackPrice
            self.releaseDateLabel.text = song.releaseDate
            self.collectionNameLabel.text = song.collectionName
        }
        
        
        DispatchQueue.global().async {
            if let url = URL(string: song.artworkUrl100) {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.artworkImageView.image = UIImage(data: data)
                    }
            
                } catch {}
            }
        }
    }

}
