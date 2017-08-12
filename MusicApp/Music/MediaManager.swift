//
//  MediaManager.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/10/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

// This class control playing music like play, stop, pause, set new media collection

class MediaManager: NSObject, AVAudioPlayerDelegate {
    
    // MARK: Variables
    
    static let shared = MediaManager()
    
    var mediaCollection: MediaCollection? {
        didSet {
            notifyChange()
        }
    }
    var audioPlayer: AVAudioPlayer?
    var currentMedia: MPMediaItem?
    var playMode = PlayMode.repeatAll
    var groupingType = GroupingType.collection
    
    // MARK: Life Cycle
    
    private override init() {
        super.init()
        setRunInBackground()
        addObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Methods
    
    func setRunInBackground() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback, with: .defaultToSpeaker)
        } catch {
            
        }
    }
    
    func setItems(items: [MPMediaItem], groupingType: GroupingType) {
        mediaCollection = MediaCollection()
        mediaCollection?.items = items
        self.groupingType = groupingType
    }
    
    func isPlaying() -> Bool {
        guard let player = audioPlayer else {
            return false
        }
        return player.isPlaying
    }
    
    func isAlready() -> Bool {
        if audioPlayer != nil {
            return true
        } else {
            return false
        }
    }
    
    func playSong(mediaItem: MPMediaItem) {
        if let url = mediaItem.assetURL {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                currentMedia = mediaItem
                notifyChange()
                showOnLockScreen()
            } catch {
                
            }
        }
    }
    
    func showOnLockScreen() {
        guard let currentItem = currentMedia else {
            return
        }
        var artwork = currentItem.artwork
        if artwork == nil {
            let image = #imageLiteral(resourceName: "question-blue")
            artwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in
                return image
            })
        }
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle : currentItem.title ?? "unknown",
            MPMediaItemPropertyArtist : currentItem.artist ?? "unknown",
            MPMediaItemPropertyPlaybackDuration : currentItem.playbackDuration,
            MPMediaItemPropertyArtwork : artwork!
        ]
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    func pauseSong() {
        audioPlayer?.pause()
        notifyChange()
    }
    
    func stopSong() {
        audioPlayer?.pause()
        audioPlayer?.currentTime = 0
        UIApplication.shared.endReceivingRemoteControlEvents()
        notifyChange()
    }
    
    func replayCurrentSong() {
        stopSong()
        audioPlayer?.play()
        notifyChange()
    }
    
    func forward() {
        switch playMode {
        case .repeatAll, .repeatOne, .once:
            playNext()
        case .random:
            playRandom()
        }
    }
    
    func playRandom() {
        guard let collection = mediaCollection else {
            return
        }
        guard collection.count > 0 else {
            return
        }
        let randomIndex = Int(arc4random()) % collection.count
        let randomMedia = collection.getItem(at: randomIndex)
        playSong(mediaItem: randomMedia)
    }
    
    func playNext() {
        guard let collection = mediaCollection else {
            return
        }
        guard let currentItem = currentMedia else {
            return
        }
        guard collection.count > 0 else {
            return
        }
        if var i = collection.items.index(of: currentItem) {
            i = (i+1)%collection.count
            let media = collection.getItem(at: i)
            playSong(mediaItem: media)
        } else {
            playFirst()
        }
    }
    
    func playFirst() {
        guard let collection = mediaCollection else {
            return
        }
        if collection.count > 0 {
            let media = collection.getItem(at: 1)
            playSong(mediaItem: media)
        }
    }
    
    func backward() {
        switch playMode {
        case .repeatAll, .repeatOne, .once:
            playPrevious()
        case .random:
            playRandom()
        }
    }
    
    func playPrevious() {
        guard let collection = mediaCollection else {
            return
        }
        guard let currentItem = currentMedia else {
            return
        }
        guard collection.count > 0 else {
            return
        }
        if var i = collection.items.index(of: currentItem) {
            i = (i-1+collection.count)%collection.count
            let media = collection.getItem(at: i)
            playSong(mediaItem: media)
        } else {
            playFirst()
        }
    }
    
    func playContinue() {
        audioPlayer?.play()
        notifyChange()
    }
    
    // auto play when finish a song
    func autoPlay() {
        switch playMode {
        case .repeatAll:
            playNext()
        case .repeatOne:
            replayCurrentSong()
        case .once:
            stopSong()
        case .random:
            playRandom()
        }
    }
    
    func setPlayMode(mode: PlayMode) {
        playMode = mode
        notifyChange()
    }
    
    // MARK: Declare Play Mode Enum
    
    enum PlayMode {
        case once, repeatOne, repeatAll, random
    }
    
}

// MARK: Notification

extension MediaManager {
    
    // MARK: Notification
    
    func notifyChange() {
        NotificationCenter.default.post(name: Notification.Name(Constant.Notification.updateMediaManagerAction), object: self)
    }
    
    // MARK: Add Observers
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(playPauseAction), name: Notification.Name(Constant.Notification.playPauseAction), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(forwardAction), name: Notification.Name(Constant.Notification.forwardAction), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(backwardAction), name: Notification.Name(Constant.Notification.backwardAction), object: nil)
    }
    
    func playPauseAction() {
        guard let player = audioPlayer else {
            return
        }
        if player.isPlaying {
            pauseSong()
        } else {
            playContinue()
        }
    }
    
    func forwardAction() {
        forward()
    }
    
    func backwardAction() {
        backward()
    }
    
    // MARK: AVAudioPlayerDelegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        autoPlay()
    }
    
    // Declare enum 
    
    enum GroupingType {
        case collection, album, artist
    }
    
}
