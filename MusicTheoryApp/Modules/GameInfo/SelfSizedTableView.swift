//
//  SelfSizedTableViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.05.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
    //MARK: - Constant
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height - 60.0
    
    //MARK: - Overriden methods
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
