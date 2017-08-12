//
//  Constant.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/10/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import Foundation

class Constant {
    
    private init() {}
    
    class Notification {
        
        static let playPauseAction = "com.cuong.ios.music.playPauseAction"
        
        static let forwardAction = "com.cuong.ios.music.forwardAction"
        
        static let backwardAction = "com.cuong.ios.music.backwardAction"
        
        static let updateMediaManagerAction = "com.cuong.ios.music.updateMediaManagerAction"
        
    }
    
    class Cell {
        static let songTableCellIdentifier = "songTableCell"
        static let listCell = "listCell"
        static let gridCell = "gridCell"
    }
    
}
