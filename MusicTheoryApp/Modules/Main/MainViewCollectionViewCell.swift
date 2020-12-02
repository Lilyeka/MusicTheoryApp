//
//  MainViewCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 08.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    let CIRCLE_RADIUS: CGFloat = 50.0
    let TRACK_LINE_WIDTH: CGFloat = 4.0
    
    // MARK: - Static elements
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - UIElements
    var textLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
       // label.backgroundColor = .green
        return label
    }()
    
    var imageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    var shapeLayer: CAShapeLayer!
    var trackLayer: CAShapeLayer!
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame:.zero)
    
        imageView.image = UIImage(named:"trebleClef")
        contentView.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 2*CIRCLE_RADIUS).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 2*CIRCLE_RADIUS).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        //textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animationFunc() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
      //  self.layer.cornerRadius = self.frame.size.width / 2
      //  self.layer.backgroundColor = #colorLiteral(red: 0.3014289141, green: 0.8125473857, blue: 0.8772042394, alpha: 1).withAlphaComponent(0.5).cgColor
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        let center = imageView.center
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = TRACK_LINE_WIDTH
        contentView.layer.addSublayer(trackLayer)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = TRACK_LINE_WIDTH
        shapeLayer.strokeEnd = 0
        contentView.layer.addSublayer(shapeLayer)
    }

    override func prepareForReuse() {
         imageView.image = nil
    }
}
