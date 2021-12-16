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
            let resizedImage = UIImage.resizeImage(image:image,targetSize: CGSize(width: viewModel.durationWidth, height: viewModel.durationHeight))
            imageView.image = resizedImage
        }
        
        self.contentView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50.0 - viewModel.offsetFromDurationCenter).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewModel.durationHeight).isActive = true
        imageView.setNeedsDisplay()
        
        self.contentView.addSubview(viewForFireworks)
        viewForFireworks.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        viewForFireworks.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        viewForFireworks.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
        viewForFireworks.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
    }
    
    override func prepareForReuse() {
        imageView.removeFromSuperview()
        viewForFireworks.removeFromSuperview()
    }
}
