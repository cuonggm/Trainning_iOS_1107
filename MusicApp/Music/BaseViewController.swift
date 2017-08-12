//
//  BaseViewController.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/9/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // fix table view header's space
        automaticallyAdjustsScrollViewInsets = false
    }

}
