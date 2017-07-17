//
//  MainViewController.swift
//  bai8-9
//
//  Created by Cuong Giap Minh on 7/17/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UITextField!
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
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

}
