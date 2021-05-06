//
//  UIStackView+Extension.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 06.05.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
