//
//  EbookTableImageCell.swift
//  bai10
//
//  Created by Cuong Giap Minh on 8/3/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class EbookTableImageCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    var playImageView: UIImageView!
    var showPlayButton = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindImage(imageUrl: String) {
        do {
            let url = URL(string: imageUrl)
            let data = try Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.thumbnailImage.image = UIImage(data: data)
                if self.showPlayButton == true {
                    self.addPlayImage()
                }
            }
        } catch {}
    }
    
    private func addPlayImage() {
        let image = UIImage(named: "play-button")
        let width:CGFloat = 64
        let height:CGFloat = width
        let x = (thumbnailImage.frame.width - width) / 2
        let y = (thumbnailImage.frame.height - height) / 2
        let playImageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        playImageView.image = image
        thumbnailImage.addSubview(playImageView)
    }
    
    private func removePlayImage() {
        playImageView.removeFromSuperview()
    }
    
}
