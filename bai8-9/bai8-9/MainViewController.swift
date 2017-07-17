//
//  MainViewController.swift
//  bai8-9
//
//  Created by Cuong Giap Minh on 7/17/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

let keyForProgress = "com.cuong.ios.bai8-9.keyForProgress"

class MainViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(keyForProgress), object: nil, queue: nil, using: handleProgress(notification:))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SongTableViewCell
        DispatchQueue.global().sync {
            cell.bindData(song: songs[indexPath.row])
        }
        return cell
    }
    
    @IBAction func loadSongs(sender: UIButton) {
        if (searchView.text?.isEmpty)! {
            return
        }
        searchView.endEditing(true)
        songs = []
        tableView.reloadData()
        
        DispatchQueue.global().async {
            ItuneConnection.defaultConnection.searchSongs(searchString: self.searchView.text!) { (song) in
                self.songs.append(song)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func handleProgress(notification: Notification) {
        
        if let userInfo = notification.userInfo as? [String: Any] {
            if let progress = userInfo["progress"] as? Float {
                DispatchQueue.main.async {
                    print("progress = \(progress)")
                    if progress == 0 {
                        self.progressView.isHidden = false
                        self.progressView.progress = 0
                    }
                    else if (progress > 0 && progress < 1) {
                        if self.progressView.isHidden {
                            self.progressView.isHidden = false
                        }
                        self.progressView.progress = progress
                    }
                    else if progress >= 1 {
                        self.progressView.isHidden = true
                        self.progressView.progress = 0
                    }

                }
            }
        }
    }
}
