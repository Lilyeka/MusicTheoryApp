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
        
    // MARK: - UIElements
    var textLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
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
        label.textColor = UIColor(named: "doneArticleColour")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Пройдено 0%"
        return label
    }()
    
    var viewModel: QuizArticleViewModel?
    var shapeLayer: CAShapeLayer!
    var trackLayer: CAShapeLayer!
    var previousTrackLayer: CAShapeLayer!
   
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews(viewModel:QuizArticleViewModel, frame:CGRect) {
        self.viewModel = viewModel
        self.layer.cornerRadius = 10 //5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.textLabel.text = viewModel.articleTitle()
        self.textLabel.font = viewModel.HEADER_FONT
        
        self.contentView.addSubview(self.textLabel)
        self.contentView.addSubview(imageView)
    
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(self.resultLabel)
        self.contentView.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.textLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5.0),
            self.textLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5.0),
            
            self.imageView.widthAnchor.constraint(equalToConstant: 2 * CIRCLE_RADIUS),
            self.imageView.heightAnchor.constraint(equalToConstant: 2 * CIRCLE_RADIUS),
            self.imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 8.0),
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.resultLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            self.resultLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            self.resultLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            
            bottomView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8.0),
            bottomView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0)
        ])
    }
    
    func animationFunc() {
        let center = imageView.center
        let path = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: viewModel!.previousPercentInAngle, endAngle: viewModel!.percentInAngle, clockwise: true)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor(named: "doneArticleColour")?.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = TRACK_LINE_WIDTH
        shapeLayer.strokeEnd = 0
        contentView.layer.addSublayer(shapeLayer)
        
        CATransaction.begin()
          CATransaction.setCompletionBlock({ [viewModel] in
            viewModel?.afterAnimation()
          })
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        CATransaction.commit()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if trackLayer != nil { trackLayer.removeFromSuperlayer() }
        if previousTrackLayer != nil { previousTrackLayer.removeFromSuperlayer() }
        if shapeLayer != nil { shapeLayer.removeFromSuperlayer() }
        
        resultLabel.text = viewModel?.resultTitle()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.image = UIImage(named: viewModel?.imageName ?? "trebleClef")
    
        let center = imageView.center
        trackLayer = CAShapeLayer()
        circularPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: -CGFloat.pi/2, endAngle: viewModel!.percentInAngle, clockwise: true)
        trackLayer.path = circularPath?.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = TRACK_LINE_WIDTH
        contentView.layer.addSublayer(trackLayer)

        previousTrackLayer = CAShapeLayer()
        let prevCircularPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: -CGFloat.pi/2, endAngle: viewModel!.previousPercentInAngle, clockwise: true)
        previousTrackLayer.path = prevCircularPath.cgPath
        previousTrackLayer.strokeColor = UIColor(named: "doneArticleColour")?.cgColor
        previousTrackLayer.lineCap = .round
        previousTrackLayer.fillColor = UIColor.clear.cgColor
        previousTrackLayer.lineWidth = TRACK_LINE_WIDTH
        contentView.layer.addSublayer(previousTrackLayer)
    }
    
    func clearModel() {
        viewModel?.clearArticleResult()
        if trackLayer != nil { trackLayer.removeFromSuperlayer() }
        if previousTrackLayer != nil { previousTrackLayer.removeFromSuperlayer() }
        if shapeLayer != nil {shapeLayer.removeFromSuperlayer()}
        setNeedsDisplay()
    }
}
