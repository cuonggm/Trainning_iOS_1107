//
//  PlayingViewController.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/11/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayingViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var playModeButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: Slider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Varialbes
    
    var media: MPMediaItem?
    var timer: Timer?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        setupTableView()
        DispatchQueue.main.async {
            self.update()
        }
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: Methods
    
    func update() {
        tableView.reloadData()
        guard let currentItem = MediaManager.shared.currentMedia else {
            return
        }
        switch MediaManager.shared.groupingType {
        case .collection:
            titleLabel.text = currentItem.title ?? "unknown"
            descriptionLabel.text = currentItem.artist ?? "unknown"
        case .album:
            titleLabel.text = currentItem.albumTitle ?? "unknown"
            descriptionLabel.text = currentItem.albumArtist ?? "unknown"
        case .artist:
            titleLabel.text = currentItem.artist ?? "unknown"
            descriptionLabel.text = currentItem.title ?? "unknown"
        }
        
        updatePlayModeUI()
        updatePlayPauseButtonImage()
        updateSlider()
        if let player = MediaManager.shared.audioPlayer {
            durationLabel.text = "\(getTimeString(number: player.duration))"
        }
        scrollToCurrentRow()
    }
    
    // update current time label
    func updateCurrentTimeLabel() {
        if let player = MediaManager.shared.audioPlayer {
            currentTimeLabel.text = "\(self.getTimeString(number: player.currentTime))"
        }
    }
    
    // update slider
    func updateSlider() {
        guard let player = MediaManager.shared.audioPlayer else {
            return
        }
        slider.minimumValue = 0
        slider.maximumValue = Float(player.duration)
        slider.value = Float(player.currentTime)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if let player = MediaManager.shared.audioPlayer {
                self.slider.value = Float(player.currentTime)
                self.updateCurrentTimeLabel()
            }
        })
        timer?.fire()
    }
    
    // convert time format
    func getTimeString(number: Double) -> String {
        let intNumber = Int(number)
        let minute = intNumber / 60
        let second = intNumber % 60
        
        var min = "\(minute)"
        if min.characters.count == 1 {
            min = "0" + min
        }
        
        var sec = "\(second)"
        if sec.characters.count == 1 {
            sec = "0" + sec
        }
        return "\(min):\(sec)"
    }
    
    // set image play mode button
    func setNoRepeatImage() {
        playModeButton.setImage(#imageLiteral(resourceName: "no-repeat"), for: .normal)
    }
    
    func setRepeatAllImage() {
        playModeButton.setImage(#imageLiteral(resourceName: "repeat-all"), for: .normal)
    }
    
    func setRepeatOnceImage() {
        playModeButton.setImage(#imageLiteral(resourceName: "repeat-once"), for: .normal)
    }
    
    func setRandomImage() {
        playModeButton.setImage(#imageLiteral(resourceName: "random"), for: .normal)
    }
    
    // set Play Pause button image
    func setPlayImage() {
        playPauseButton.setImage(#imageLiteral(resourceName: "circle-play-white-100"), for: .normal)
    }
    
    func setPauseImage() {
        playPauseButton.setImage(#imageLiteral(resourceName: "circle-pause-fill-white-100"), for: .normal)
    }
    
    func updatePlayPauseButtonImage() {
        if MediaManager.shared.isPlaying() {
            setPauseImage()
        } else {
            setPlayImage()
        }
    }
    
    // update play mode image
    func updatePlayModeUI() {
        switch MediaManager.shared.playMode {
        case .once:
            setNoRepeatImage()
        case .repeatAll:
            setRepeatAllImage()
        case .repeatOne:
            setRepeatOnceImage()
        case .random:
            setRandomImage()
        }
    }
    
    // MARK: IBAction
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playPauseAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name(Constant.Notification.playPauseAction), object: self)
    }

    @IBAction func backwardAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name(Constant.Notification.backwardAction), object: self)
    }
    
    @IBAction func forwardAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name(Constant.Notification.forwardAction), object: self)
    }
    
    @IBAction func changePlayModeAction(_ sender: UIButton) {
        switch MediaManager.shared.playMode {
        case .once:
            MediaManager.shared.setPlayMode(mode: .repeatAll)
        case .repeatAll:
            MediaManager.shared.setPlayMode(mode: .repeatOne)
        case .repeatOne:
            MediaManager.shared.setPlayMode(mode: .random)
        case .random:
            MediaManager.shared.setPlayMode(mode: .once)
        }
    }
    @IBAction func slideAction(_ sender: Slider) {
        let value = sender.value
        MediaManager.shared.audioPlayer?.currentTime = TimeInterval(value)
        updateCurrentTimeLabel()
    }
    
    // MARK: Notification
    // Observers
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: Notification.Name(Constant.Notification.updateMediaManagerAction), object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: Table View DataSouce and Delegate

extension PlayingViewController: UITableViewDataSource, UITableViewDelegate {
    
    // setup TableView
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50.0
        let nib = UINib(nibName: "SongTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constant.Cell.songTableCellIdentifier)
    }
    
    // Table's Methods
    
    func scrollToCurrentRow() {
        guard let collection = MediaManager.shared.mediaCollection else {
            return
        }
        guard collection.count > 0 else {
            return
        }
        guard let currentMedia = MediaManager.shared.currentMedia else {
            return
        }
        if let index = collection.items.index(of: currentMedia) {
            if index >= 0 && index < tableView.numberOfRows(inSection: 0) {
                let indexPath = IndexPath(row: index, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
    
    // MARK: Table Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaManager.shared.mediaCollection?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.songTableCellIdentifier, for: indexPath) as! SongTableCell
        cell.bindData(index: indexPath.row)
        return cell
    }
    
    // MARK: Table Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedMedia = MediaManager.shared.mediaCollection?.getItem(at: indexPath.row) {
            MediaManager.shared.playSong(mediaItem: selectedMedia)
        }
    }
    
}
