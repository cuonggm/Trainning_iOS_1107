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
    
    init(captureDate: Date, avValue: Float, loviValue: Int) {
        self.captureDate = captureDate
        self.avValue = avValue
        self.loviValue = loviValue
    }
}
