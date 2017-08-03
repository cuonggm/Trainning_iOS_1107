//
//  TabBarControllerViewController.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/19/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
        title = tabBar.selectedItem?.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTabs() {
        let musicVideoTab = ListMediaController()
        let musicVideoTabItem = UITabBarItem(title: "Music Video", image: UIImage(named: "music-video"), tag: 0)
        musicVideoTab.tabBarItem = musicVideoTabItem
        musicVideoTab.mediaType = "musicVideo"
        
        let movieTab = ListMediaController()
        let movieTabItem = UITabBarItem(title: "Movie", image: UIImage(named: "movie"), tag: 0)
        movieTab.tabBarItem = movieTabItem
        movieTab.mediaType = "movie"
        
        let ebookTab = ListMediaController()
        let ebookTabItem = UITabBarItem(title: "Ebook", image: UIImage(named: "ebook"), tag: 0)
        ebookTab.tabBarItem = ebookTabItem
        ebookTab.mediaType = "ebook"
        
        let audioBookTab = ListMediaController()
        let audioBookTabItem = UITabBarItem(title: "Audio Book", image: UIImage(named: "audio-book"), tag: 0)
        audioBookTab.tabBarItem = audioBookTabItem
        audioBookTab.mediaType = "audiobook"
        
        let podcastTab = ListMediaController()
        let podcastTabItem = UITabBarItem(title: "Podcast", image: UIImage(named: "podcast"), tag: 0)
        podcastTab.tabBarItem = podcastTabItem
        podcastTab.mediaType = "podcast"
        
        viewControllers = [musicVideoTab, movieTab, ebookTab, audioBookTab, podcastTab]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = item.title
    }
}
