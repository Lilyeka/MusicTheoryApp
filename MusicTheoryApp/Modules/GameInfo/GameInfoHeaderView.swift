//
//  GameInfoHeaderView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.05.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit

protocol GameInfoHeaderViewDelegate {
    func closeTapped()
}

class GameInfoHeaderView: UIView {
    //MARK: -Delegate
    var delegate: GameInfoHeaderViewDelegate?
    
    //MARK: -Constants
    static let HEADER_FONT: UIFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title1), size: 25.0)
    
    //MARK: -UI Elements
    var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = GameInfoHeaderView.HEADER_FONT
        label.numberOfLines = 0
        return label
    }()
    
    var closeButton: UIButton = {
        var btn = UIButton(type: .close)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withText: String) {
        super.init(frame: .zero)
        self.configureObjects(text: withText)
    }
    
    //MARK: -Private methods
    fileprivate func configureObjects(text: String = "") {
        self.label.text = text
        self.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        self.addSubview(self.label)
        self.addSubview(self.closeButton)
        
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0),
        ])
    }
    
    //MARK: -Actions
    @objc func closeTapped() {
        self.delegate?.closeTapped()
    }
}
