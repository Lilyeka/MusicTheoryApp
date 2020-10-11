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
    func configureSubviews(viewModel:PauseViewModel) {
        self.viewModel = viewModel
        
        let image = UIImage(named: self.viewModel.imageName)
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0/*50.0 - viewModel.offsetFromDurationCenter*/).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: viewModel.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewModel.height).isActive = true
    }
}
