//
//  MainViewCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 08.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {
    // MARK: - UIElements
    var textLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    var imageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame:.zero)
        
        contentView.addSubview(textLabel)
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5).isActive = true
        
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -5).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.backgroundColor = #colorLiteral(red: 0.3014289141, green: 0.8125473857, blue: 0.8772042394, alpha: 1).withAlphaComponent(0.5).cgColor
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
