//
//  UICollectionViewCell+Extension.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 16.12.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static let QUESTION_FONT: UIFont = {
        if (DeviceType.IS_IPHONE_11_XR_11PMax_XsMax ||
            DeviceType.IS_IPHONE_11Pro_X_Xs ||
            DeviceType.IS_IPHONE_12_12Pro_13_13Pro) {
            return UIFont.boldSystemFont(ofSize: 23.0)
        } else if DeviceType.IS_IPHONE_12ProMax_13ProMax {
            return UIFont.boldSystemFont(ofSize: 25.0)
        } else {
            return UIFont.boldSystemFont(ofSize: 20.0)
        }
     }()
}
