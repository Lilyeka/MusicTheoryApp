//
//  QuizAdditionPausesCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 03.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionPausesCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    //MARK: -ViewModel
    var viewModel: PauseViewModel!
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Public methods
//    func configureSubviews(viewModel:PauseViewModel) {
//        self.contentView.backgroundColor = .orange
//    }
}
