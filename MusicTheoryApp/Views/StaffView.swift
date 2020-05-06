//
//  Staff.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit


class StaffView: UIView {
    
    var clefImageView: UIImageView = {
        var imageView = UIImageView()
        //imageView.backgroundColor = .green
        imageView.image = UIImage(named: "clef_new")!
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var shouldSetupConstraints = true
    static let VERTICAL_OFFSET = 60
    static let LINE_OFFSET = 30
    static let LINE_WIDTH: CGFloat = 2.0
    
    static func viewHeight() -> Int {
        return (VERTICAL_OFFSET*2 + Int(LINE_WIDTH)*5 + LINE_OFFSET*4)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    fileprivate func setupView() {
        drawLines()
        self.addSubview(clefImageView)
        clefImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        clefImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        clefImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        clefImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    func drawNotes(notes: [NoteViewModel]) {
        let horizOffset: CGFloat = -10.0
        let noteWidth: CGFloat = 60.0
        let noteHeight: CGFloat = 64.0
            
        var i = 0
        for note in notes {
            let imageView = UIImageView()
            //imageView.backgroundColor = .blue
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            // картинка для ноты
            if let durationImageName = note.imagesForNote.duration {
                imageView.image = UIImage(named: durationImageName)
                // TODO: если у ноты есть еще и тональность то отрисовать значок тональности в отдельной imageView
                if let toneImageName = note.imagesForNote.tone {
                }
            } else {
                //если просто тональность
                if let toneImageName = note.imagesForNote.tone {
                     imageView.image = UIImage(named: toneImageName)
                }
            }
            // разбираемся с расположением
            self.addSubview(imageView)
            let leftOffsetFromClef = horizOffset + CGFloat(i)*noteWidth

            imageView.leftAnchor.constraint(equalTo: clefImageView.rightAnchor, constant:leftOffsetFromClef).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: noteWidth).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: noteHeight).isActive = true
                
            let y: CGFloat = notePosition(note:note)
            imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: y).isActive = true
            i += 1
        }
    }
    
    fileprivate func notePosition(note: NoteViewModel) -> CGFloat {
        let offsetLinePositions = (CGFloat(note.model.name.rawValue)/2.0)*CGFloat(StaffView.LINE_OFFSET)
        return -CGFloat(StaffView.VERTICAL_OFFSET) - offsetLinePositions
    }
    
    fileprivate func drawLines() {
        let lineStartX = 0
        let lineEndX = Int(self.bounds.maxX)

        var i = 0
        while i < 5 {
            let lineY = Int(self.bounds.maxY) - StaffView.VERTICAL_OFFSET - i*StaffView.LINE_OFFSET
            drawLine(startX: lineStartX, toEndingX: lineEndX, startingY: lineY, toEndingY: lineY, ofColor: .black, widthOfLine: StaffView.LINE_WIDTH, inView: self)
            i += 1
        }
    }
    
    fileprivate func drawLine(startX: Int, toEndingX endX: Int, startingY startY: Int, toEndingY endY: Int, ofColor lineColor: UIColor, widthOfLine lineWidth: CGFloat, inView view: UIView) {

        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        view.layer.addSublayer(shapeLayer)
    }
}
