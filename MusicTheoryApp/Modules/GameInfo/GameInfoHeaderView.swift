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
        label.text = " "
        label.textColor = #colorLiteral(red: 0.07422413677, green: 0.5216350555, blue: 0.8784367442, alpha: 1)//#colorLiteral(red: 0.3014289141, green: 0.8125473857, blue: 0.8772042394, alpha: 1)
        label.font = GameInfoHeaderView.HEADER_FONT
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
        configureObjects()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withText: String, frame: CGRect) {
        super.init(frame:frame)
        configureObjects(text: withText)
    }
    
     //MARK: -Private methods
    fileprivate func configureObjects(text: String = "") {
        self.addSubview(label)
        label.text = text
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0).isActive = true
        
        self.addSubview(closeImageView)
        closeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        closeImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
        closeImageView.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
        closeImageView.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        closeImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: -Actions
    @objc func closeTapped() {
        self.delegate?.closeTapped()
    }
}
