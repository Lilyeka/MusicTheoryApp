//
//  QuizVariantCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 26.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizVariantCollectionViewCell: UICollectionViewCell {
    //MARK: -Views
    var viewForFireworks: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
     }()
    
    //MARK: -ViewModel
    var viewModel: NoteViewModel!
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Public methods
    func configureSubviews(viewModel:NoteViewModel) {
        self.viewModel = viewModel
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 13.0
        
        let image = UIImage(named: self.viewModel.durationImageName)
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50.0 - viewModel.offsetFromDurationCenter).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: viewModel.durationWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewModel.durationHeight).isActive = true
    
        self.contentView.addSubview(viewForFireworks)
        viewForFireworks.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        viewForFireworks.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        viewForFireworks.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
        viewForFireworks.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
    }
}
