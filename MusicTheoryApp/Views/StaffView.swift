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
    static let CLEFT_LEFT_OFFSET: CGFloat = 10.0
    static let CLEF_WIDTH: CGFloat = 80.0
    var notesArray:[NoteViewModel]?
    var pickedOutNotesIndexes:[Int] = [Int]()
 
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(notesViewModels:[NoteViewModel], frame:CGRect) {
        super.init(frame:frame)
        self.notesArray = notesViewModels
        setupView()
    }
    
    fileprivate func setupView() {
        drawLines()
        self.addSubview(clefImageView)
        clefImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: StaffView.CLEFT_LEFT_OFFSET).isActive = true
        clefImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        clefImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        clefImageView.widthAnchor.constraint(equalToConstant: StaffView.CLEF_WIDTH).isActive = true
    }

    func drawNotesOneByOne() {
        let offsetBetwenNotes: CGFloat = 35.0
        let offsetFromClef: CGFloat = 35.0
        var previousNoteWidth: CGFloat = 0.0
        var previousLeftOffsetFromClef: CGFloat = 0.0
        
        var i = 0
        for note in notesArray! {
            note.alfa = NoteViewModel.TRANSPARENT_ALFA
            let noteCharacteristics = note.noteImagesHeightsAndCentersPositions()
            let leftOffsetFromClef = i == 0 ? offsetFromClef : (previousLeftOffsetFromClef + previousNoteWidth + offsetBetwenNotes)
            let offsetLinePositions = CGFloat(note.model.name.rawValue)/2.0*CGFloat(StaffView.LINE_OFFSET)
            // картинка для ноты
            if let durationImageName = noteCharacteristics.duration,
                let noteHeight = noteCharacteristics.durationHeight,
                let noteWidth = noteCharacteristics.durationWidth,
                let offsetFromCenterY = noteCharacteristics.durationCenterOffesetY {
                let durationPositionY = -CGFloat(StaffView.VERTICAL_OFFSET) - offsetLinePositions - offsetFromCenterY
                //дополнительная линейка
                if note.needsAdditionalLine {
                    let addLineXOffset = 7
                    let noteStartXPosition = Int(StaffView.CLEFT_LEFT_OFFSET + StaffView.CLEF_WIDTH + leftOffsetFromClef)
                    drawLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: noteStartXPosition + Int(noteWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY),
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY),
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                let imageView = UIImageView()
                imageView.tag = i
                //imageView.backgroundColor = .green
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleAspectFit
                let img = UIImage(named: durationImageName)
                imageView.image = img
                imageView.alpha = note.alfa
                // расположение ноты
                self.addSubview(imageView)
                imageView.leftAnchor.constraint(equalTo: clefImageView.rightAnchor, constant:leftOffsetFromClef).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: noteHeight).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: noteWidth).isActive = true
                imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: durationPositionY).isActive = true
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(noteTapped(tapGestureRecognizer:)))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tapGestureRecognizer)
                
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
                    let offsetFromCenterY = noteCharacteristics.toneCenterOffesetY {
                    let durationPositionY = -CGFloat(StaffView.VERTICAL_OFFSET) - offsetLinePositions - offsetFromCenterY
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
                    imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: durationPositionY).isActive = true
                    previousLeftOffsetFromClef = leftOffsetFromClef
                    previousNoteWidth = toneWidth
                }
            }
            i += 1
        }
    }
    
    @objc func noteTapped(tapGestureRecognizer:UITapGestureRecognizer) {
        let noteViewModelNumber = tapGestureRecognizer.view?.tag
        let noteViewModel = notesArray![noteViewModelNumber!]
        noteViewModel.didTapped()
        tapGestureRecognizer.view?.alpha = noteViewModel.alfa
        
        if pickedOutNotesIndexes.contains(noteViewModelNumber!) {
            let index = pickedOutNotesIndexes.firstIndex(of: noteViewModelNumber!)
            pickedOutNotesIndexes.remove(at: index!)
        } else {
            pickedOutNotesIndexes.append(noteViewModelNumber!)
        }
        print(pickedOutNotesIndexes)
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
