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
    let TRACK_LINE_WIDTH: CGFloat = 5.0
    
    var circularPath: UIBezierPath?
        
    // MARK: - UIElements
    var textLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .black
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
        label.textColor = UIColor(named: "doneArticleColour")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
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
    
    func configureSubviews(viewModel: QuizArticleViewModel, frame:CGRect) {
        self.viewModel = viewModel
        self.layer.cornerRadius = 10 //5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.textLabel.text = viewModel.articleTitle()
        self.textLabel.font = viewModel.HEADER_FONT
        self.resultLabel.font = viewModel.TEXT_FONT
    
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
        
        self.shapeLayer = CAShapeLayer()
        self.shapeLayer.path = path.cgPath
        self.shapeLayer.strokeColor = UIColor(named: "doneArticleColour")?.cgColor
        self.shapeLayer.lineCap = .round
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.lineWidth = TRACK_LINE_WIDTH
        self.shapeLayer.strokeEnd = 0
        self.contentView.layer.addSublayer(self.shapeLayer)
        
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
        if self.trackLayer != nil { self.trackLayer.removeFromSuperlayer() }
        if self.previousTrackLayer != nil { self.previousTrackLayer.removeFromSuperlayer() }
        if self.shapeLayer != nil { self.shapeLayer.removeFromSuperlayer() }
        
        self.resultLabel.text = viewModel?.resultTitle()
        self.imageView.layer.cornerRadius = imageView.frame.size.width/2
        self.imageView.image = UIImage(named: viewModel?.imageName ?? "trebleClef")
    
        let center = self.imageView.center
        self.trackLayer = CAShapeLayer()
        self.circularPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: -CGFloat.pi/2, endAngle: viewModel!.percentInAngle, clockwise: true)
        self.trackLayer.path = self.circularPath?.cgPath
        self.trackLayer.strokeColor = UIColor.lightGray.cgColor
        self.trackLayer.lineCap = .round
        self.trackLayer.fillColor = UIColor.clear.cgColor
        self.trackLayer.lineWidth = self.TRACK_LINE_WIDTH
        self.contentView.layer.addSublayer(trackLayer)

        self.previousTrackLayer = CAShapeLayer()
        let prevCircularPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS, startAngle: -CGFloat.pi/2, endAngle: self.viewModel!.previousPercentInAngle, clockwise: true)
        self.previousTrackLayer.path = prevCircularPath.cgPath
        self.previousTrackLayer.strokeColor = UIColor(named: "doneArticleColour")?.cgColor
        self.previousTrackLayer.lineCap = .round
        self.previousTrackLayer.fillColor = UIColor.clear.cgColor
        self.previousTrackLayer.lineWidth = TRACK_LINE_WIDTH
        self.contentView.layer.addSublayer(self.previousTrackLayer)
    }
    
    func clearModel() {
        self.viewModel?.clearArticleResult()
        if trackLayer != nil { trackLayer.removeFromSuperlayer() }
        if previousTrackLayer != nil { self.previousTrackLayer.removeFromSuperlayer() }
        if self.shapeLayer != nil { self.shapeLayer.removeFromSuperlayer() }
        self.setNeedsDisplay()
    }
}
