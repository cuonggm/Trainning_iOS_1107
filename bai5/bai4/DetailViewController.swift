//
//  DetailViewController.swift
//  bai4
//
//  Created by Cuong Giap Minh on 7/14/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avlabel: UILabel!
    @IBOutlet weak var loviLabel: UILabel!
    
    var avResult: AVResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = avResult {
            dateLabel.text = result.captureDateString
            avlabel.text = "\(result.avValue)"
            loviLabel.text = "\(result.loviValue)"
        }
        
    }
}
