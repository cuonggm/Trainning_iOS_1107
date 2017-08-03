//
//  PodcastTableViewController.swift
//  bai10
//
//  Created by Cuong Giap Minh on 8/4/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class PodcastTableViewController: UITableViewController {
    
    // cell identifiers
    let imageCellIdentifier = "AudioBookImageCell"
    let infoCellIdentifier = "AudioBookInfoCell"
    
    // variables
    var item: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _item = item {
            title = _item.collectionName
        }
        // auto resize height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        // register cells
        let imageNib = UINib(nibName: "EbookTableImageCell", bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: imageCellIdentifier)
        let infoNib = UINib(nibName: "EbookTableInfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: infoCellIdentifier)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier, for: indexPath) as! EbookTableImageCell
            cell.bindImage(imageUrl: (item?.artworkUrl100)!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Collection Name", content: (item?.collectionName)!)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Artist Name", content: (item?.artistName)!)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Track Name", content: "\((item?.trackName)!)")
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Feed Url", content: (item?.feedUrl)!)
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Track Count", content: "\(item?.trackCount ?? 0)")
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Release Date", content: (item?.releaseDate)!)
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Country", content: (item?.country)!)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
