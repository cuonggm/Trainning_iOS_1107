//
//  AVResult.swift
//  bai4
//
//  Created by Cuong Giap Minh on 7/14/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AVResult: NSManagedObject {
    @NSManaged var captureDate: Date
    @NSManaged var avValue: Float
    @NSManaged var loviValue: Int

}
