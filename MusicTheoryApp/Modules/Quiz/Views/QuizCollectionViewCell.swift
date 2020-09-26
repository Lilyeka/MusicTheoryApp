//
//  QuizCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    // MARK: - UIElements
    var questionView: UIView? 
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func config(withView: UIView) {
        contentView.backgroundColor = .white
        
        questionView = withView
        questionView!.translatesAutoresizingMaskIntoConstraints = false
        questionView?.clipsToBounds = true
       
        contentView.addSubview(questionView!)
        questionView!.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        questionView!.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        questionView!.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
       // questionView!.heightAnchor.constraint(equalToConstant: 350).isActive = true
        questionView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        //layoutIfNeeded()
       // questionView!.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func prepareForReuse() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
}
