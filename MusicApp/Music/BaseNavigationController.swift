//
//  BaseNavigationController.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/9/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // disable navigation bar indicator
        // navigationBar.shadowImage = UIImage()
    }
    
}
