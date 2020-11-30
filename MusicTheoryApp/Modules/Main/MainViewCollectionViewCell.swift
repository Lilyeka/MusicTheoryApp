//
//  MainViewCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 08.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {
    // MARK: - Static elements
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
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
    
    var shapeLayer: CAShapeLayer!//()
    var trackLayer: CAShapeLayer!//()
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame:.zero)
        
        contentView.addSubview(textLabel)
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5).isActive = true
        
        imageView.image = UIImage(named:"trebleClef")
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -5).isActive = true
        
        //view.backgroundColor = .white
        
        
        
     //   let trackLayer = CAShapeLayer()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animationFunc() {
        print("attempting to animate stroke")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.backgroundColor = #colorLiteral(red: 0.3014289141, green: 0.8125473857, blue: 0.8772042394, alpha: 1).withAlphaComponent(0.5).cgColor
        
        let center = contentView.center
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10
        contentView.layer.addSublayer(trackLayer)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        contentView.layer.addSublayer(shapeLayer)
    }

    override func prepareForReuse() {
         imageView.image = nil
    }
}
