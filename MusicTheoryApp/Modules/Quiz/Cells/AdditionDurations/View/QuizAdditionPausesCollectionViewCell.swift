//
//  QuizAdditionPausesCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 03.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionPausesCollectionViewCell: UICollectionViewCell {

    //MARK: -Views
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var viewForFireworks: UIView! = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    //MARK: -ViewModel
    var viewModel: PauseViewModelSeparate!
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Public methods
    func configureSubviews(viewModel: PauseViewModelSeparate) {
        self.viewModel = viewModel
        
        let image = UIImage(named: self.viewModel.imageName)
        if let image = image {
            let resizedImage = image.scalePreservingAspectRatio(targetSize: CGSize(width: viewModel.width, height: viewModel.height))
            self.imageView.image = resizedImage
        }
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.viewForFireworks)
        
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: self.viewModel.width),
            self.imageView.heightAnchor.constraint(equalToConstant: self.viewModel.height),
            
            self.viewForFireworks.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.viewForFireworks.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.viewForFireworks.widthAnchor.constraint(equalToConstant: 10.0),
            self.viewForFireworks.heightAnchor.constraint(equalToConstant: 10.0)
        ])
    }
    
    override func prepareForReuse() {
        imageView.removeFromSuperview()
        viewForFireworks.removeFromSuperview()
    }
}
