//
//  SongListCell.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/9/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

class ListCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Methods
    
    func bindData(item: MPMediaItem) {
        
        titleLabel.text = item.title
        if let artist = item.artist {
            descriptionLabel.text = artist
        } else {
            descriptionLabel.text = "unknown"
        }
        if let image = item.artwork?.image(at: CGSize(width: 100, height: 100)) {
            imageView.image = image
        } else {
            imageView.image = #imageLiteral(resourceName: "question-512")
        }
    }
    
    func bindData(albumItem: MPMediaItemCollection) {
        guard let item = albumItem.representativeItem else {
            clear()
            return
        }
        titleLabel.text = item.albumTitle
        if let artist = item.albumArtist {
            descriptionLabel.text = "\(artist) - \(albumItem.count) song(s)"
        } else {
            descriptionLabel.text = "unknown"
        }
        if let image = item.artwork?.image(at: CGSize(width: 100, height: 100)) {
            imageView.image = image
        } else {
            imageView.image = #imageLiteral(resourceName: "question-512")
        }
    }
    
    func bindData(artistItem: MPMediaItemCollection) {
        guard let item = artistItem.representativeItem else {
            clear()
            return
        }
        titleLabel.text = item.artist
        descriptionLabel.text = "\(artistItem.count) song(s)"
        if let image = item.artwork?.image(at: CGSize(width: 100, height: 100)) {
            imageView.image = image
        } else {
            imageView.image = #imageLiteral(resourceName: "question-512")
        }
    }
    
    func clear() {
        titleLabel.text = "unknown"
        descriptionLabel.text = "unknown"
        imageView.image = #imageLiteral(resourceName: "question-512")
    }
    
}
