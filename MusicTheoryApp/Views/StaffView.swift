//
//  Staff.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit


class StaffView: UIView {
    static let VERTICAL_OFFSET = 60
    static let LINE_OFFSET = 30
    static let LINE_WIDTH: CGFloat = 2.0
    
    var clefImageView: UIImageView = {
        var imageView = UIImageView()
        //imageView.backgroundColor = .green
        imageView.image = UIImage(named: "clef_new")!
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static func viewHeight() -> Int {
        let linesThicknessHeight = Int(LINE_WIDTH)*5
        let linesOffset = LINE_OFFSET*4
        let offsetFromTopAndBottom = VERTICAL_OFFSET*2
        return (offsetFromTopAndBottom + linesOffset + linesThicknessHeight)
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
   
    
    func drawNotesOneByOne(notes: [NoteViewModel]) {
        let offsetBetwenNotes: CGFloat = 25.0
        let offsetFromClef: CGFloat = 35.0
        var previousNoteWidth: CGFloat = 0.0
        var previousLeftOffsetFromClef: CGFloat = 0.0
        
        var i = 0
        for note in notes {
            let noteCharacteristics = note.noteImagesHeightsAndCentersPositions(verticalOffset: CGFloat(StaffView.VERTICAL_OFFSET), lineOffset: CGFloat(StaffView.LINE_OFFSET))
            let leftOffsetFromClef = i == 0 ? offsetFromClef : (previousLeftOffsetFromClef + previousNoteWidth + offsetBetwenNotes)
            // картинка для ноты
            if let durationImageName = noteCharacteristics.duration,
                let noteHeight = noteCharacteristics.durationHeight,
                let noteWidth = noteCharacteristics.durationWidth,
                let y = noteCharacteristics.durationY {
                let imageView = UIImageView()
                //imageView.backgroundColor = .green
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleAspectFit
                let img = UIImage(named: durationImageName)
                imageView.image = img
                imageView.alpha = 0.5
                // расположение ноты
                self.addSubview(imageView)
                imageView.leftAnchor.constraint(equalTo: clefImageView.rightAnchor, constant:leftOffsetFromClef).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: noteHeight).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: noteWidth).isActive = true
                imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: y).isActive = true
                previousLeftOffsetFromClef = leftOffsetFromClef
                previousNoteWidth = noteWidth
                // TODO: если у ноты есть еще и тональность то отрисовать значок тональности в отдельной imageView
                if let toneImageName = noteCharacteristics.tone {
                }
            } else {
                //если просто тональность (без ноты)
                if let toneImageName = noteCharacteristics.tone,
                    let toneHeight = noteCharacteristics.toneHeight,
                    let toneWidth = noteCharacteristics.toneWidth,
                    let y = noteCharacteristics.toneY {
                    let imageView = UIImageView()
                    //imageView.backgroundColor = .gray
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = UIImage(named: toneImageName)
                    // расположение тональности
                    self.addSubview(imageView)
                    imageView.leftAnchor.constraint(equalTo: clefImageView.rightAnchor, constant:leftOffsetFromClef).isActive = true
                    imageView.heightAnchor.constraint(equalToConstant: toneHeight).isActive = true
                    imageView.widthAnchor.constraint(equalToConstant: toneWidth).isActive = true
                    imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: y).isActive = true
                    previousLeftOffsetFromClef = leftOffsetFromClef
                    previousNoteWidth = toneWidth
                }
            }
            i += 1
        }
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
