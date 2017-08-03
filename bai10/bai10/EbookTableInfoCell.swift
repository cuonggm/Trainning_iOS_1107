//
//  EbookTableInfoCell.swift
//  bai10
//
//  Created by Cuong Giap Minh on 8/3/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class EbookTableInfoCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindInfo(title: String, content: String) {
        self.title.text = title
        self.content.text = content
    }
    
}
