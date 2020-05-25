//
//  String+Extension.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 24.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height + 5
    }
}
