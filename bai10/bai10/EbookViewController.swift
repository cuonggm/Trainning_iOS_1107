//
//  EbookViewController.swift
//  bai10
//
//  Created by Cuong Giap Minh on 8/3/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class EbookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // define cell identifiers
    let imageCellIdentifier = "EbookTableImageCell"
    let infoCellIdentifier = "EbookTableInfoCell"

    var item: Ebook?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _item = item {
            title = _item.trackCensoredName
        }
        
        // set delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // auto resize row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        
        // register cells
        let nib = UINib(nibName: "EbookTableImageCell", bundle: nil)
        tableView.register(nib , forCellReuseIdentifier: imageCellIdentifier)
        
        let infoNib = UINib(nibName: "EbookTableInfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: infoCellIdentifier)
        
    }
    
    // number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier, for: indexPath) as! EbookTableImageCell
            cell.bindImage(imageUrl: (item?.artworkUrl100)!)
            cell.showPlayButton = true
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Track Censored Name", content: (item?.trackCensoredName)!)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "File Size", content: "\(item?.fileSizeBytes ?? 0)")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Artist Name", content: (item?.artistName)!)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Genres", content: (item?.genresString)!)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            let priceString = "\((item?.price)!)" + " " + (item?.currency)!
            cell.bindInfo(title: "Price", content: priceString)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Description", content: (item?.description)!)
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Release Date", content: item?.releaseDate ?? "")
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "Average User Rating", content: "\(item?.averageUserRating ?? 0)")
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath) as! EbookTableInfoCell
            cell.bindInfo(title: "User Rating Count", content: "\(item?.userRatingCount ?? 0)")
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
