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
        
        let siteLabel = UILabel()
        siteLabel.text = "Приглашаем посетить наш сайт"
        siteLabel.textAlignment = .center
        
        let siteButton = UIButton()
        siteButton.setTitle("наш сайт", for: .normal)
        siteButton.setTitleColor(.blue, for: .normal)
        siteButton.tag = 0
        self.buttonsArray.append(siteButton)
        siteButton.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
        
        let topVertStackView = UIStackView()
        topVertStackView.translatesAutoresizingMaskIntoConstraints = false
        topVertStackView.axis = .vertical
        topVertStackView.distribution = .fillProportionally
        topVertStackView.alignment = .fill
        
        topVertStackView.addArrangedSubview(siteLabel)
        topVertStackView.addArrangedSubview(siteButton)
        
        self.contentView.addSubview(topVertStackView)
        topVertStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        topVertStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Благодарим за предоставленные иконки:"
        label.textAlignment = .center
        
        self.contentView.addSubview(label)
        label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: OFFSET).isActive = true
        label.topAnchor.constraint(equalTo: topVertStackView.bottomAnchor, constant: OFFSET).isActive = true
        label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -OFFSET).isActive = true
        
        let verticalLeftStackView = UIStackView()
        verticalLeftStackView.axis = .vertical
        verticalLeftStackView.distribution = .fillEqually
        verticalLeftStackView.alignment = .fill
        
        var i = 1
        while i < 4 {
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
        
        i = 4
        while i < 7 {
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
        hStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -OFFSET).isActive = true

    }
    
    @objc func linkButtonClicked(sender: UIButton) {
        self.buttonClickedAction?(sender.tag)
    }
}
