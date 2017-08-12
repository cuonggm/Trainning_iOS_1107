//
//  MusicRemoteView.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/9/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class MusicRemoteView: UIView {
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    // MARK: Variables
    var tabBarController: TabBarController?
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXibFile()
        addObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXibFile()
    }
    
    func loadXibFile() {
        let rootView = Bundle.main.loadNibNamed("MusicRemoteView", owner: self, options: nil)?.first as! UIView
        rootView.frame = self.bounds
        addSubview(rootView)
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: Methods
    
    func setVisible(bool: Bool) {
        isHidden = !bool
    }
    
    func show() {
        setVisible(bool: true)
    }
    
    func hide() {
        setVisible(bool: false)
    }
    
    func setPlayImage() {
        playPauseButton.setImage(#imageLiteral(resourceName: "play-white-100"), for: .normal)
        playPauseButton.setImage(#imageLiteral(resourceName: "play-100"), for: .highlighted)
    }
    
    func setPauseImage() {
        playPauseButton.setImage(#imageLiteral(resourceName: "pause-white-100"), for: .normal)
        playPauseButton.setImage(#imageLiteral(resourceName: "pause-100"), for: .highlighted)
    }
    
    func updatePlayPauseImage() {
        if (MediaManager.shared.isPlaying()) {
            setPauseImage()
        } else {
            setPlayImage()
        }
    }
    
    func update() {
        if MediaManager.shared.isAlready() {
            show()
        } else {
            hide()
        }
        updatePlayPauseImage()
        guard let currentMedia = MediaManager.shared.currentMedia else {
            return
        }
        if let image = currentMedia.artwork?.image(at: CGSize(width: 100, height: 100)) {
            imageView.image = image
        } else {
            imageView.image = #imageLiteral(resourceName: "question-512")
        }
        if let title = currentMedia.title {
            songLabel.text = title
        }
        if let artist = currentMedia.artist {
            artistLabel.text = artist
        }
        
    }

    // MARK: IBAction
    
    @IBAction func playPauseAction(_ sender: UIButton) {
        notifyPlayPause()
    }
    
    @IBAction func forwardAction(_ sender: UIButton) {
        notifyForward()
    }
    @IBAction func backwardAction(_ sender: UIButton) {
        notifyBackward()
    }
    
    @IBAction func showPlayingViewController(_ sender: UITapGestureRecognizer) {
        guard let currentMedia = MediaManager.shared.currentMedia else {
            return
        }
        tabBarController?.showPlayingController(media: currentMedia)
    }
    
}

// MARK: Notification

extension MusicRemoteView {
    
    // MARK: Notification
    
    func notifyPlayPause() {
        NotificationCenter.default.post(name: Notification.Name(Constant.Notification.playPauseAction), object: self)
    }
    
    func notifyForward() {
        NotificationCenter.default.post(name: Notification.Name(Constant.Notification.forwardAction), object: self)
    }
    
    func notifyBackward() {
        NotificationCenter.default.post(name: Notification.Name(Constant.Notification.backwardAction), object: self)
    }
    
    // MARK: Observers Notification
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: Notification.Name(Constant.Notification.updateMediaManagerAction), object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

}
