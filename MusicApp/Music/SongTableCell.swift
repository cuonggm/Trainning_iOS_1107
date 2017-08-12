//
//  SongTableCell.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/11/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

class SongTableCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var soundwaveImage: UIImageView!
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Methods
    
    func bindData(index: Int) {
        if let media = MediaManager.shared.mediaCollection?.getItem(at: index) {
            titleLabel.text = media.title ?? "unknown"
            artistLabel.text = media.artist ?? "unknown"
            indexLabel.text = "\(index+1)"
            updateSoundwaveImage(index: index)
        } else {
            clear()
        }
    }
    
    func updateSoundwaveImage(index: Int) {
        guard let currentMedia = MediaManager.shared.currentMedia else {
            soundwaveImage.image = UIImage()
            return
        }
        guard let currentItem = MediaManager.shared.mediaCollection?.getItem(at: index) else {
            soundwaveImage.image = UIImage()
            return
        }
        if (currentMedia === currentItem && MediaManager.shared.isPlaying()) {
            soundwaveImage.image = UIImage.gif(name: "soundwave")
        } else {
            soundwaveImage.image = UIImage()
        }
    }
    
    func clear() {
        titleLabel.text = "unknown"
        artistLabel.text = "unknown"
        indexLabel.text = "unknown"
    }
    
}
