//
//  GameInfoLinksTableViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.05.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit

class GameInfoLinksTableViewCell: UITableViewCell {
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
    
    
//gettyimages    https://www.gettyimages.co.uk/
//vhv    https://www.vhv.rs/
//Pngguru https://www.pngguru.in/
//pngegg    https://www.pngegg.com/
// pngtree https://pngtree.com/
//flaticon https://www.flaticon.com/
    
    //MARK: -Private methods
    fileprivate func configureObjects() {
        let textViewLinksLeft = UITextView()
        textViewLinksLeft.isEditable = false
        textViewLinksLeft.isScrollEnabled = false
        textViewLinksLeft.isSelectable = true
        textViewLinksLeft.dataDetectorTypes = .link
        textViewLinksLeft.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 60, right: 0)
        textViewLinksLeft.linkTextAttributes = [NSAttributedString.Key.foregroundColor : LINKS_COLOR]
        let atributedLinksString = stringWithLinks(nameAndLinks: ["gettyimages":"https://www.gettyimages.co.uk/",
             "vhv": "https://www.vhv.rs/",
             "pngguru": "https://www.pngguru.in/"], addAdditionalInfo: true)
        textViewLinksLeft.attributedText = atributedLinksString
        textViewLinksLeft.sizeToFit()
        
        let textViewLinksRight = UITextView()
        textViewLinksRight.isEditable = false
        textViewLinksRight.isScrollEnabled = false
        textViewLinksRight.isSelectable = true
        textViewLinksRight.dataDetectorTypes = .link
        textViewLinksRight.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        textViewLinksRight.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        
        textViewLinksRight.attributedText = stringWithLinks(nameAndLinks: ["pngegg":"https://www.pngegg.com/",
             "pngtree":"https://pngtree.com/",
             "flaticon":"https://www.flaticon.com/"],addAdditionalInfo: false)
        textViewLinksRight.sizeToFit()
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(textViewLinksLeft)
        stackView.addArrangedSubview(textViewLinksRight)
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: OFFSET).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -OFFSET).isActive = true
        
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
        bottomTextView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: -OFFSET*2).isActive = true
        bottomTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -OFFSET).isActive = true
        bottomTextView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        bottomTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -OFFSET).isActive = true
    }
    
      fileprivate func stringWithLinks(nameAndLinks:[String:String], addAdditionalInfo: Bool) -> NSMutableAttributedString {
          let resultString = NSMutableAttributedString(string: "")
          for (name,linkAddress) in nameAndLinks.sorted(by: {$0.0 < $1.0}) {
              let linkName = "\n" + name
              let attrStringWithLinks = NSMutableAttributedString(string: linkName)
              attrStringWithLinks.addAttribute(.link, value: linkAddress, range: NSRange(location: 0, length: attrStringWithLinks.length))
              resultString.append(attrStringWithLinks)
          }
      
          let range = NSMakeRange(0, resultString.length)
          resultString.addAttribute(NSAttributedString.Key.font, value: FONT, range: range)
          resultString.addAttribute(NSAttributedString.Key.foregroundColor, value: FONT_COLOR, range: range)
    
          return resultString
      }
}
