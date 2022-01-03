//
//  QuizAdditionSignsCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 02.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionSignsCollectionViewCell: UICollectionViewCell {
    //MARK: -Static
  
    static let SIGN_FONT: UIFont = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
            return UIFont.boldSystemFont(ofSize: 73.0)
        }
        return UIFont.boldSystemFont(ofSize: 70.0)
    }()
    
    //MARK: -Views
    var signLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = QuizAdditionSignsCollectionViewCell.SIGN_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var textField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.textAlignment = .center
        textField.font = QuizAdditionSignsCollectionViewCell.SIGN_FONT
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }()
    
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bemol")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: -ViewModel
    var model: MathSignViewModel!
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Public methods
    func configureSubviews(model: MathSignViewModel) {
        self.model = model
       
        if model.model.sign != .question {
            self.signLabel.text = model.signText
            self.signLabel.textColor = model.signFontColor
           
            self.contentView.addSubview(self.signLabel)
            NSLayoutConstraint.activate([
                self.signLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                self.signLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                self.signLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
                self.signLabel.heightAnchor.constraint(equalToConstant: 120.0)
            ])
        } else {
            self.textField.placeholder = model.signText
            
            self.contentView.addSubview(self.textField)
            NSLayoutConstraint.activate([
                self.textField.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                self.textField.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                self.textField.widthAnchor.constraint(equalTo:self.contentView.widthAnchor),
                self.textField.heightAnchor.constraint(equalTo:self.contentView.heightAnchor)
            ])
        }
    }
    
    override func prepareForReuse() {
        textField.removeFromSuperview()
        signLabel.removeFromSuperview()
    }
}


