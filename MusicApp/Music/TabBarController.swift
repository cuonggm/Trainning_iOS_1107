//
//  TabBarController.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/9/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable
class TabBarController: UITabBarController {
    
    // MARK: Variables
    
    var musicRemoteView: MusicRemoteView!
    var mediaManager = MediaManager.shared
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make tab bar transparent and set tint color
        tabBar.backgroundImage = UIImage()
        UITabBar.appearance().tintColor = UIColor(red: 208/255, green: 64/255, blue: 118/255, alpha: 1)
        
        // position remove bar above tab bar
        setupMusicRemoteView()
        
        DispatchQueue.main.async {
            self.checkPermissionDenied()
        }
    }
    
    // MARK: Methods
    
    // update image of play/pause button on music remote view
    func updateRemoteViewUI() {
        if !mediaManager.isPlaying() {
            musicRemoteView.setPlayImage()
        }
    }
    
    // position remove bar above tab bar
    func setupMusicRemoteView() {
        let width = view.frame.width
        let height = CGFloat(55.0)
        let x = CGFloat(0)
        let y = tabBar.frame.origin.y - CGFloat(height)
        musicRemoteView = MusicRemoteView(frame: CGRect(x: x, y: y, width: width, height: height))
        view.addSubview(musicRemoteView)
        musicRemoteView.setVisible(bool: false)
        musicRemoteView.tabBarController = self
    }
    
    // check Permission Denied
    func checkPermissionDenied() {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .denied {
                print("Denied roi")
                let alert = UIAlertController(title: "Permission Denied", message: "Your app is not allowed to access Music Library!\n Go Setting -> Music App -> Turn on permission and restart your app.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK! Understood ...", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // present Playing View Controller
    func showPlayingController(media: MPMediaItem) {
        let playingVC = PlayingViewController()
        playingVC.media = media
        present(playingVC, animated: true, completion: nil)
    }
    
    // MARK: control remote on lockscreen
    override func remoteControlReceived(with event: UIEvent?) {
        if let event = event {
            switch event.subtype {
            case .remoteControlPlay:
                mediaManager.playContinue()
            case .remoteControlPause:
                mediaManager.pauseSong()
            case .remoteControlStop:
                mediaManager.stopSong()
            case .remoteControlNextTrack:
                mediaManager.forward()
            case .remoteControlPreviousTrack:
                mediaManager.backward()
            default:
                break
            }
        }
    }

}
