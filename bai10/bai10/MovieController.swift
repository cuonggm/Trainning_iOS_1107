//
//  MovieController.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/24/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MovieController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movie: Movie?
    
    let cellIdentifier = "MovieCell"
    @IBOutlet weak var tableView: UITableView!
    var imageView: UIImageView!
    var tapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _item = movie {
            title = _item.trackName
        }
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        // imageView
        setupTableHeader()
        DispatchQueue.global(qos: .userInitiated).async {
            if let _movie = self.movie {
                if let urlString = _movie.artworkUrl100 {
                    let url = URL(string: urlString)!
                    do {
                        let data = try Data(contentsOf: url)
                        self.imageView.image = UIImage(data: data)
                        self.addPlayImage()
                    } catch {}
                }
            }
        }
    }
    
    func addPlayImage() {
        guard let previewImageView = imageView else {
            return
        }
        let image = UIImage(named: "play-button")
        let width:CGFloat = 64
        let height:CGFloat = width
        let x = (previewImageView.frame.width - width) / 2
        let y = (previewImageView.frame.height - height) / 2
        let playImageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        playImageView.image = image
        previewImageView.addSubview(playImageView)
    }
    
    func previewMovie(recognizer: UITapGestureRecognizer) {
        guard let urlString = movie?.previewUrl else {
            return
        }
        DispatchQueue.main.async {
            let url = URL(string: urlString)!
            let player = AVPlayer(url: url)
            let playerVC = AVPlayerViewController()
            playerVC.player = player
            player.play()
            self.present(playerVC, animated: true, completion: nil)
        }
    }
    
    func setupTableHeader() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        tableView.tableHeaderView = imageView
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(previewMovie))
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.isUserInteractionEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Kind"
            cell.contentLabel.text = movie?.kind
        case 1:
            cell.titleLabel.text = "Collection ID"
            cell.contentLabel.text = "\(movie?.collectionId ?? -1)"
        case 2:
            cell.titleLabel.text = "Track ID"
            cell.contentLabel.text = "\(movie?.trackId ?? -1)"
        case 3:
            cell.titleLabel.text = "Artist Name"
            cell.contentLabel.text = movie?.artistName
        case 4:
            cell.titleLabel.text = "Collection Name"
            cell.contentLabel.text = movie?.collectionName
        case 5:
            cell.titleLabel.text = "Track Name"
            cell.contentLabel.text = movie?.trackName
        case 6:
            cell.titleLabel.text = "Collection Price"
            cell.contentLabel.text = "\(movie?.collectionPrice ?? 0)"
        case 7:
            cell.titleLabel.text = "Track Price"
            cell.contentLabel.text = "\(movie?.trackPrice ?? 0)"
        case 8:
            cell.titleLabel.text = "Track Rental Price"
            cell.contentLabel.text = "\(movie?.trackRentalPrice ?? 0)"
        case 9:
            cell.titleLabel.text = "Collection HD Price"
            cell.contentLabel.text = "\(movie?.collectionHdPrice ?? 0)"
        case 10:
            cell.titleLabel.text = "Track HD Price"
            cell.contentLabel.text = "\(movie?.trackHdPrice ?? 0)"
        case 11:
            cell.titleLabel.text = "Track HD Rental Price"
            cell.contentLabel.text = "\(movie?.trackHdRentalPrice ?? 0)"
        case 12:
            cell.titleLabel.text = "Release Date"
            let date = movie?.releaseDate ?? "nil"
            cell.contentLabel.text = date
        case 13:
            cell.titleLabel.text = "Disc Count"
            cell.contentLabel.text = "\(movie?.discCount ?? 0)"
        case 14:
            cell.titleLabel.text = "Disc Number"
            cell.contentLabel.text = "\(movie?.discNumber ?? 0)"
        case 15:
            cell.titleLabel.text = "Track Count"
            cell.contentLabel.text = "\(movie?.trackCount ?? 0)"
        case 16:
            cell.titleLabel.text = "Track Number"
            cell.contentLabel.text = "\(movie?.trackNumber ?? 0)"
        case 17:
            cell.titleLabel.text = "Short Description"
            cell.contentLabel.text = movie?.shortDescription
        case 18:
            cell.titleLabel.text = "Long Description"
            cell.contentLabel.text = movie?.longDescription
        case 19:
            cell.titleLabel.text = "Country"
            cell.contentLabel.text = movie?.country
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
