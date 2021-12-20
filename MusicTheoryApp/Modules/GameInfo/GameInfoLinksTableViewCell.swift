//
//  GameInfoLinksTableViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.05.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit
typealias Sources = (name: String, url: String)

class GameInfoTableViewCell: UITableViewCell {
    var buttonClickedAction: ((Int)->())?
    var buttonsArray: [UIButton] = [UIButton]()
    
    var sourcesAndLinks: [Sources]! {
        didSet {
            buttonsArray.forEach { button in
                button.setTitle(sourcesAndLinks[button.tag].name, for: .normal)
            }
        }
    }
    
    //MARK: -Static variables
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    //MARK: -Constants
    let LINKS_COLOR: UIColor = .blue
    let OFFSET: CGFloat = 10.0
    var FONT: UIFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 16.0)
    var FONT_COLOR: UIColor = #colorLiteral(red: 0.07422413677, green: 0.5216350555, blue: 0.8784367442, alpha: 1)
    
 
    //MARK: -Lifecycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureObjects()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Private methods
    fileprivate func configureObjects() {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Благодарим за предоставленные иконки:"
        label.textAlignment = .center
        label.textColor = FONT_COLOR
        
        self.contentView.addSubview(label)
        label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: OFFSET).isActive = true
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: OFFSET).isActive = true
        label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -OFFSET).isActive = true
        
        let verticalLeftStackView = UIStackView()
        verticalLeftStackView.axis = .vertical
        verticalLeftStackView.distribution = .fillEqually
        verticalLeftStackView.alignment = .fill
        
        var i = 0
        while i < 3 {
            let button = UIButton()
            button.setTitleColor(.blue, for: .normal)
            button.tag = i
            self.buttonsArray.append(button)
            button.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
            verticalLeftStackView.addArrangedSubview(button)
            i += 1
        }
        
        let verticalRightStackView = UIStackView()
        verticalRightStackView.axis = .vertical
        verticalRightStackView.distribution = .fillEqually
        verticalRightStackView.alignment = .fill
        
        i = 3
        while i < 6 {
            let button = UIButton()
            button.setTitleColor(.blue, for: .normal)
            button.tag = i
            self.buttonsArray.append(button)
            button.addTarget(self, action:  #selector(linkButtonClicked), for: .touchUpInside)
            verticalRightStackView.addArrangedSubview(button)
            i += 1
        }
        
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.alignment = .fill
        
        hStackView.addArrangedSubview(verticalLeftStackView)
        hStackView.addArrangedSubview(verticalRightStackView)
        
        self.contentView.addSubview(hStackView)
        hStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: OFFSET).isActive = true
        hStackView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        hStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -OFFSET).isActive = true
        
        let resultString = NSMutableAttributedString(string: " Наш ")
        let attrStringWithLink = NSMutableAttributedString(string: "сайт")
        attrStringWithLink.addAttribute(.link, value: "http://tatianastupak.com/" , range: NSRange(location: 0, length: attrStringWithLink.length))
        resultString.append(attrStringWithLink)
        
        let range = NSMakeRange(0, resultString.length)
        resultString.addAttribute(NSAttributedString.Key.font, value: FONT, range: range)
        resultString.addAttribute(NSAttributedString.Key.foregroundColor, value: FONT_COLOR, range: range)
        
        let bottomTextView = UITextView()
        bottomTextView.isScrollEnabled = false
        bottomTextView.translatesAutoresizingMaskIntoConstraints = false
        bottomTextView.attributedText = resultString
        bottomTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor : LINKS_COLOR]
        bottomTextView.sizeToFit()
        
        contentView.addSubview(bottomTextView)
        bottomTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: OFFSET).isActive = true
        bottomTextView.topAnchor.constraint(equalTo: hStackView.bottomAnchor,constant: 0).isActive = true
        bottomTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -OFFSET).isActive = true
        bottomTextView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        bottomTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -OFFSET).isActive = true
    }
    
    @objc func linkButtonClicked(sender: UIButton) {
        self.buttonClickedAction?(sender.tag)
    }
}
