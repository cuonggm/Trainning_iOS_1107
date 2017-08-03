//
//  MainViewController.swift
//  bai10
//
//  Created by Cuong Giap Minh on 7/19/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.hideMenu(animated: false)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.hideMenu(animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showMenu(animated: Bool) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0) , animated: animated)
    }
    
    func hideMenu(animated: Bool) {
        scrollView.setContentOffset(CGPoint(x: view.frame.width*2/3, y: 0) , animated: animated)
    }
}
