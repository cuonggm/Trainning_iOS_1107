//
//  AlbumViewController.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/12/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate  {

    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var displayModeButton: UIButton!
    
    // MARK: Variables
    
    var mediaAlbums = MediaGroup()
    var originAlbums: MediaGroup?
    
    var displayMode = DisplayMode.list
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let listNib = UINib(nibName: "ListCell", bundle: nil)
        collectionView.register(listNib, forCellWithReuseIdentifier: Constant.Cell.listCell)
        
        let gridNib = UINib(nibName: "GridCell", bundle: nil)
        collectionView.register(gridNib, forCellWithReuseIdentifier: Constant.Cell.gridCell)
        
        setListMode()
        
        MPMediaLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.mediaAlbums.loadAlbums()
                    self.originAlbums = MediaGroup()
                    self.originAlbums?.items = self.mediaAlbums.items
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            default:
                break
            }
        }
        
        searchBar.delegate = self
        // change text color search bar
        let textFieldSearch = searchBar.value(forKey: "searchField") as? UITextField
        textFieldSearch?.textColor = UIColor.white
    }
    
    // MARK: Methods
    
    func searchAlbums(query: String) {
        guard let origin = originAlbums else {
            return
        }
        mediaAlbums.items = origin.searchAlbums(query: query)
        collectionView.reloadData()
    }
    
    // MARK: Display Mode
    
    func setListMode() {
        displayMode = .list
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.frame.width, height: 70)
        displayModeButton.setImage(#imageLiteral(resourceName: "list-100"), for: .normal)
    }
    
    func setGridMode() {
        displayMode = .grid
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.frame.width / 2, height: view.frame.width / 2 + 60)
        displayModeButton.setImage(#imageLiteral(resourceName: "grid-100"), for: .normal)
    }
    
    // MARK: Collection View Datasouce
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let media = mediaAlbums.getItem(at: indexPath.row)
        
        switch displayMode {
        case .list:
            let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Cell.listCell, for: indexPath) as! ListCell
            listCell.bindData(albumItem: media)
            return listCell
        case .grid:
            let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Cell.gridCell, for: indexPath) as! GridCell
            gridCell.bindData(albumItem: media)
            return gridCell
        }
    }
    
    // MARK: Highlight row
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        DispatchQueue.main.async {
            cell?.backgroundColor = UIColor.gray
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        DispatchQueue.main.async {
            cell?.backgroundColor = UIColor.clear
        }
    }
    
    // MARK: Play song when selected a row
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tabBar = tabBarController as? TabBarController {
            MediaManager.shared.stopSong()
            let currentAlbum = mediaAlbums.getItem(at: indexPath.row)
            MediaManager.shared.setItems(items: currentAlbum.items, groupingType: .album)
            let media = currentAlbum.items[0]
            MediaManager.shared.playSong(mediaItem: media)
            tabBar.showPlayingController(media: media)
        }
    }
    
    // MARK: Search Bar Delegate
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchAlbums(query: searchBar.text ?? "")
    }
    
    
    
    // MARK: IBAction
    
    @IBAction func loadAllAlbums(_ sender: UIButton) {
        mediaAlbums.items = originAlbums?.items ?? []
        collectionView.reloadData()
    }
    
    @IBAction func changeDisplayMode(_ sender: UIButton) {
        switch displayMode {
        case .list:
            setGridMode()
        case .grid:
            setListMode()
        }
        collectionView.reloadData()
    }

}
