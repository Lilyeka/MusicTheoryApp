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
        label.textColor = #colorLiteral(red: 0.07422413677, green: 0.5216350555, blue: 0.8784367442, alpha: 1)//#colorLiteral(red: 0.3014289141, green: 0.8125473857, blue: 0.8772042394, alpha: 1)
        label.font = GameInfoHeaderView.HEADER_FONT
        label.numberOfLines = 0
        return label
    }()
    
    var closeImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "exit")
        imageView.isUserInteractionEnabled = true
        imageView.transform = imageView.transform.rotated(by:.pi/4)
        return imageView
    }()
    
    //MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withText: String, frame: CGRect) {
        super.init(frame: frame)
        configureObjects(text: withText)
    }
    
     //MARK: -Private methods
    fileprivate func configureObjects(text: String = "") {
        self.addSubview(self.label)
        self.label.text = text
        self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(self.closeImageView)
        self.closeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        self.closeImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        self.closeImageView.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
        self.closeImageView.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        self.closeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        closeImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: -Actions
    @objc func closeTapped() {
        self.delegate?.closeTapped()
    }
}
