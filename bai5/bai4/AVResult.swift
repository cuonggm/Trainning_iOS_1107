//
//  AVResult.swift
//  bai4
//
//  Created by Cuong Giap Minh on 7/14/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class AVResult {
    var captureDate: Date
    var avValue: Float
    var loviValue: Int
    var captureDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: captureDate)
        return date
    }
    
    init(captureDate: Date, avValue: Float, loviValue: Int) {
        self.captureDate = captureDate
        self.avValue = avValue
        self.loviValue = loviValue
    }
}
