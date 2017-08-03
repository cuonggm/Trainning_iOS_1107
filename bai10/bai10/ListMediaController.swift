//
//  ListMediaController.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/19/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class ListMediaController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // define cell identifiers
    let cellIdentifier = "media"
    
    // variables
    var mediaType: String?
    var items: [Any]?
    
    // UI
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController?
    
    // when start
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController?.searchBar
        searchController?.searchBar.delegate = self
        initData()
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    // show data to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let type = mediaType else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MediaTableViewCell
        
        switch type {
        // music video cell
        case "musicVideo":
            let _item = items?[indexPath.row]
            cell?.bindMusicVideoData(item: _item!)
            return cell!
            // movie cell
        case "movie":
            let _item = items?[indexPath.row]
            cell?.bindMovieData(item: _item!)
            return cell!
            
        // ebook cell
        case "ebook":
            let _item = self.items?[indexPath.row]
            cell?.bindEbookData(item: _item!)
            return cell!
    
        // audiobook cell
        case "audiobook":
            let _item = self.items?[indexPath.row]
            cell?.bindAudioBookData(item: _item!)
            return cell!
            
        // podcast cell
        case "podcast":
            let _item = self.items?[indexPath.row]
            cell?.bindPodcastData(item: _item!)
            return cell!
            
        default:
            return UITableViewCell()
        }
    }
    
    func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        
        guard let _ = mediaType else {
            return
        }
        
        tableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    // load data from iTune
    func initData() {
        guard let type = mediaType else {
            return
        }
        let term = (searchController?.searchBar.text)!
        if term.isEmpty {
            return
        }
        DispatchQueue.global().async {
            ItuneConnection.defaultConnection.search(term: term, media: type, complete: { (json) in
                switch type {
                case "musicVideo":
                    self.items = MusicVideo.getItems(json: json)
                case "movie":
                    self.items = Movie.getItems(json: json)
                case "ebook":
                    self.items = Ebook.getItems(json: json)
                case "audiobook":
                    self.items = AudioBook.getItems(json: json)
                case "podcast":
                    self.items = Podcast.getItems(json: json)
                default:
                    break
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    // when select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let rootVC = delegate.window?.rootViewController as! MainViewController
        rootVC.hideMenu(animated: true)
        
        guard let type = mediaType else {
            return
        }
        switch type {
        case "musicVideo":
            let vc = MusicVideoController()
            vc.item = items?[indexPath.row] as? MusicVideo
            navigationController?.pushViewController(vc, animated: true)
        case "movie":
            let vc = MovieController()
            vc.movie = items?[indexPath.row] as? Movie
            navigationController?.pushViewController(vc, animated: true)
        case "ebook":
            let vc = EbookViewController()
            vc.item = items?[indexPath.row] as? Ebook
            navigationController?.pushViewController(vc, animated: true)
        case "audiobook":
            let vc = AudioBookTableViewController()
            vc.item = items?[indexPath.row] as? AudioBook
            navigationController?.pushViewController(vc, animated: true)
        case "podcast":
            let vc = PodcastTableViewController()
            vc.item = items?[indexPath.row] as? Podcast
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

// search bar
extension ListMediaController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        initData()
        searchController?.dismiss(animated: true, completion: nil)
    }
}
