//
//  UIColor+rgb.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/11/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(_ hex: Int, alpha: CGFloat = 1) -> UIColor {
        let red = CGFloat((hex >> 16) & 0xFF) / 255
        let green = CGFloat((hex >> 8) & 0xFF) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    }
}
