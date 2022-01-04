//
//  QuizAdditionVariablesCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 02.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionNotesCollectionViewCell: UICollectionViewCell {

    //MARK: -ViewModel
    var viewModel: NoteViewModel!
    
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
        
        let image = UIImage(named: self.viewModel.durationImageName)
        if let image = image {
            let resizedImage = image.scalePreservingAspectRatio(targetSize: CGSize(width: viewModel.durationWidth, height: viewModel.durationHeight))
            self.imageView.image = resizedImage
        }
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(viewForFireworks)
        
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50.0 - self.viewModel.offsetFromDurationCenter),
            self.imageView.heightAnchor.constraint(equalToConstant: viewModel.durationHeight),
            
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
