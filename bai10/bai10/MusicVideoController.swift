//
//  MusicVideoControllerViewController.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/20/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MusicVideoController: UIViewController {

    var item: MusicVideo?
    var player: AVPlayer?
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackId: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistId: UILabel!
    @IBOutlet weak var kind: UILabel!
    @IBOutlet weak var trackTimeMillis: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _item = item {
            title = _item.trackName
        }

        DispatchQueue.global(qos: .userInitiated).async {
            self.initData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.pause()
    }
    
    func initData() {
        DispatchQueue.main.async {
            self.trackName.text = self.item?.trackName
            self.trackId.text = "\(self.item?.trackId ?? -1)"
            self.artistName.text = self.item?.artistName
            self.artistId.text = "\(self.item?.artistId ?? -1)"
            self.kind.text = self.item?.kind
            self.trackTimeMillis.text = "\(self.item?.trackTimeMillis ?? 0)"
            self.country.text = self.item?.country
            self.price.text = "\(self.item?.trackPrice ?? 0)"
            self.currency.text = self.item?.currency
        }
        
        let url = URL(string: (item?.previewUrl)!)
        if let urlPath = url {
            player = AVPlayer(url: urlPath)
            let playerLayer = AVPlayerLayer(player: player)
            DispatchQueue.main.async {
                var frame = self.playerView.frame
                frame.origin.x = 0
                frame.origin.y = 0
                playerLayer.frame = frame
                playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                self.playerView.layer.addSublayer(playerLayer)
            }
            player?.play()
        }
    }
}
