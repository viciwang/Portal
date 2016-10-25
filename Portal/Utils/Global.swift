//
//  Global.swift
//  Portal
//
//  Created by Allen on 8/24/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import Foundation
import UIKit

class Global {
    static let sharedAppWindow: UIWindow = ((UIApplication.shared.delegate?.window)!)!
}

extension UIColor {
    class func hex(hex: Int64, alpha: Float = 1) -> UIColor {
        return UIColor(colorLiteralRed: Float((hex&0xff0000) >> 16)/255.0,
                       green: Float((hex&0x00ff00) >> 8)/255.0,
                       blue: Float(hex&0x0000ff)/255.0,
                       alpha: alpha)
    }
}
