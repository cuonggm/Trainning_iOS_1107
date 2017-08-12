//
//  Slider.swift
//  Music
//
//  Created by Cuong Giap Minh on 8/11/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

@IBDesignable
class Slider: UISlider {

    @IBInspectable
    var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
            setThumbImage(thumbImage, for: .highlighted)
        }
    }

}
