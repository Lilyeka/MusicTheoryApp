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
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
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
            let signLabelHight:CGFloat = 120.0
            signLabel.text = model.signText
            signLabel.textColor = model.signFontColor
            self.contentView.addSubview(signLabel)
            signLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
            signLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor/*, constant: 50.0 - viewModel.offsetFromDurationCenter*/).isActive = true
            signLabel.widthAnchor.constraint(equalTo:contentView.widthAnchor ).isActive = true
            signLabel.heightAnchor.constraint(equalToConstant: signLabelHight).isActive = true
        } else {
            textField.placeholder = model.signText
            self.contentView.addSubview(textField)
            textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor/*, constant: 50.0 - viewModel.offsetFromDurationCenter*/).isActive = true
            textField.widthAnchor.constraint(equalTo:contentView.widthAnchor ).isActive = true
            textField.heightAnchor.constraint(equalTo:contentView.heightAnchor).isActive = true
        }
    }
    
    override func prepareForReuse() {
        textField.removeFromSuperview()
        signLabel.removeFromSuperview()
    }
}


