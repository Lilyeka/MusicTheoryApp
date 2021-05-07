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
    let TRACK_LINE_WIDTH: CGFloat = 5.0//4.0
    var circularPath: UIBezierPath?
    
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
    
    var resultLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = UIColor(named: "doneArticleColour")//UIColor.red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Пройдено 0%"
        return label
    }()
    
    var endAngle: CGFloat = 0.0
    var previousEndAngle: CGFloat = 0.0
    
    var shapeLayer: CAShapeLayer!
    var trackLayer: CAShapeLayer!
    var previousTrackLayer: CAShapeLayer!
    
    var showStartButton: Bool = false
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame:.zero)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        //backgroundColor = .gray
        imageView.image = UIImage(named:"trebleClef")
        
        contentView.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
   
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 2*CIRCLE_RADIUS).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 2*CIRCLE_RADIUS).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(resultLabel)
        resultLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        resultLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        resultLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animationFunc(afterAnimation:()->()) {
        imageView.layer.removeAllAnimations()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath?.cgPath
        shapeLayer.strokeColor = UIColor(named: "doneArticleColour")?.cgColor//UIColor.red.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = TRACK_LINE_WIDTH
        shapeLayer.strokeEnd = 0
        contentView.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        afterAnimation()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        
        let center = imageView.center
        
        trackLayer = CAShapeLayer()
        circularPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: -CGFloat.pi/2, endAngle: endAngle, clockwise: true)
        trackLayer.path = circularPath?.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = TRACK_LINE_WIDTH
        contentView.layer.addSublayer(trackLayer)
        
        previousTrackLayer = CAShapeLayer()
        let prevCircularPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: -CGFloat.pi/2, endAngle: previousEndAngle, clockwise: true)
        previousTrackLayer.path = prevCircularPath.cgPath
        previousTrackLayer.strokeColor = UIColor.red.cgColor
        previousTrackLayer.lineCap = .round
        previousTrackLayer.fillColor = UIColor.clear.cgColor
        previousTrackLayer.lineWidth = TRACK_LINE_WIDTH
        contentView.layer.addSublayer(previousTrackLayer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if shapeLayer != nil { shapeLayer.removeFromSuperlayer() }
        if trackLayer != nil { trackLayer.removeFromSuperlayer() }
        if previousTrackLayer != nil { previousTrackLayer.removeFromSuperlayer() }
    }
}
