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
    
    static let SIGN_FONT: UIFont = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
            return UIFont.boldSystemFont(ofSize: 73.0)
        }
        return UIFont.boldSystemFont(ofSize: 70.0)
    }()
    
    var signFontColor: UIColor = .black
//    var pickerView: UIPickerView!
//    var pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
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
    func configureSubviews(model: MathSigns) {
        self.model = model
        let signLabelHight:CGFloat = 120.0
        var signText = ""
        switch model {
        case .addition:
            signText = "+"
        case .subtraction:
            signText = "-"
        case .equation:
            signText = "="
        case .question:
            signText = "?"
            signFontColor = UIColor.gray
        }
        
        if model != .question {
            signLabel.text = signText
            signLabel.textColor = signFontColor
            //signLabel.backgroundColor = UIColor.yellow
            //self.contentView.backgroundColor = UIColor.gray
            self.contentView.addSubview(signLabel)
            signLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
            signLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor/*, constant: 50.0 - viewModel.offsetFromDurationCenter*/).isActive = true
            signLabel.widthAnchor.constraint(equalTo:contentView.widthAnchor ).isActive = true
            signLabel.heightAnchor.constraint(equalToConstant: signLabelHight).isActive = true
        } else {
          //  pickerView = UIPickerView()
          //  pickerView.dataSource = self
            
            var textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isUserInteractionEnabled = false
            textField.textAlignment = .center
            textField.placeholder = signText
            textField.font = QuizAdditionSignsCollectionViewCell.SIGN_FONT
            textField.borderStyle = UITextField.BorderStyle.roundedRect
          //  textField.inputView = pickerView
//            textField.autocorrectionType = UITextAutocorrectionType.no
//            textField.keyboardType = UIKeyboardType.alphabet
//            textField.returnKeyType = UIReturnKeyType.done
//            textField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
//            textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            
            self.contentView.addSubview(textField)
            textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor/*, constant: 50.0 - viewModel.offsetFromDurationCenter*/).isActive = true
            textField.widthAnchor.constraint(equalTo:contentView.widthAnchor ).isActive = true
            textField.heightAnchor.constraint(equalTo:contentView.heightAnchor).isActive = true
        }
    }
}

//extension QuizAdditionSignsCollectionViewCell: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        pickerData.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "dsdsdsd"//pickerData[row]
//    }
//}
