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
         if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
             return UIFont.boldSystemFont(ofSize: 23.0)
         }
         return UIFont.boldSystemFont(ofSize: 20.0)
     }()
}
