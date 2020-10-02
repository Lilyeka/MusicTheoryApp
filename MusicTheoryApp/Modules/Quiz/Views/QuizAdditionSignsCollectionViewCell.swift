//
//  QuizAdditionSignsCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 02.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionSignsCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    //MARK: -ViewModel
    var model: MathSigns!
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Public methods
    func configureSubviews(model:MathSigns) {
        self.contentView.backgroundColor = .yellow
    }
}
