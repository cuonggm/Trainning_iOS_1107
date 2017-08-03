//
//  MediaTableCellTableViewCell.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/19/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    func bindEbookData(item: Any) {
        let _item = item as! Ebook
        DispatchQueue.main.async {
            self.titleLabel.text = _item.trackCensoredName
            self.artistLabel.text = _item.genresString
            self.priceLabel.text = "\(_item.price ?? 0.0)"
            self.currencyLabel.text = _item.currency
        }
        loadThumbnailImage(imageUrl: _item.artworkUrl100 ?? "")
    }
    
    func bindMovieData(item: Any) {
        let _item = item as! Movie
        DispatchQueue.main.async {
            self.titleLabel.text = _item.trackName
            self.artistLabel.text = _item.artistName
            self.priceLabel.text = "\(_item.trackPrice ?? 0.0)"
            self.currencyLabel.text = _item.currency
        }
        loadThumbnailImage(imageUrl: _item.artworkUrl100 ?? "")
    }
    
    func bindMusicVideoData(item: Any) {
        let _item = item as! MusicVideo
        DispatchQueue.main.async {
            self.titleLabel.text = _item.trackName
            self.artistLabel.text = _item.artistName
            self.priceLabel.text = "\(_item.trackPrice ?? 0.0)"
            self.currencyLabel.text = _item.currency
        }
        loadThumbnailImage(imageUrl: _item.artworkUrl100!)
    }
    
    func bindAudioBookData(item: Any) {
        let _item = item as! AudioBook
        DispatchQueue.main.async {
            self.titleLabel.text = _item.collectionName
            self.artistLabel.text = _item.artistName
            self.priceLabel.text = "\(_item.collectionPrice ?? 0)"
            self.currencyLabel.text = _item.currency ?? ""
        }
        loadThumbnailImage(imageUrl: _item.artworkUrl100!)
    }
    
    func bindPodcastData(item: Any) {
        let _item = item as! Podcast
        DispatchQueue.main.async {
            self.titleLabel.text = _item.collectionName
            self.artistLabel.text = _item.artistName
            self.priceLabel.text = "Free"
            self.currencyLabel.isHidden = true
        }
        loadThumbnailImage(imageUrl: _item.artworkUrl100!)
    }
    
    func loadThumbnailImage(imageUrl: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let url = URL(string: imageUrl)!
            var data: Data?
            do {
                data = try Data(contentsOf: url)
                
            } catch {}
            if data != nil {
                DispatchQueue.main.async {
                    self.artworkImageView.image = UIImage(data: data!)
                }
            }
        }

    }
}
