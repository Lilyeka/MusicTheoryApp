//
//  GameInfoTableViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.05.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit

class GameInfoTableViewCell: UITableViewCell {
    // MARK: - Static vars
    public static var reuseIdentifier: String {
         return String(describing: self)
     }
    // MARK: - Constants
    var OFFSET: CGFloat = 10.0
    var IMAGE_IN_TEXTVIEW_SIZE: CGFloat = 28.0
    var FONT: UIFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 16.0)
    var FONT_COLOR: UIColor = #colorLiteral(red: 0.07422413677, green: 0.5216350555, blue: 0.8784367442, alpha: 1)
    var numberOfLines: Int = 2

    // MARK: - UIElements
    var textView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        textView.text = ""
        return textView
    }()
 
    // MARK: - Private Methods
    func configureTextView() {
        contentView.isUserInteractionEnabled = false
        
        let gameDescrString = gameDescriptionString()
        textView.attributedText = gameDescrString
        textView.sizeToFit()
        
        contentView.addSubview(textView)
        textView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: OFFSET).isActive = true
        textView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -OFFSET).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
    }
    
    fileprivate func gameDescriptionString() -> NSMutableAttributedString {
        let sampleText = """
        Благодарим за предоставленные иконки:
        """
            
        let mutableAttrString = NSMutableAttributedString(string: sampleText)
        let range = NSMakeRange(0, mutableAttrString.length)
        mutableAttrString.addAttribute(NSAttributedString.Key.font, value: FONT, range: range)
        mutableAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: FONT_COLOR, range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        mutableAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle,range: range)
        return mutableAttrString
    }

}
