//
//  Staff.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol StaffViewDelegate {
    func pickedOutNotesIndexesDidChange(newValue: [Int])
}

class StaffView: UIView {    
    static let VERTICAL_OFFSET:Int = {
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            return 65
        }
        if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            return 70
        }
        if DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 73
        }
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 75
        }
        return 65
    }()
    static let LINE_WIDTH: CGFloat = 2.0
    
    static var LINE_OFFSET: Int = {
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            return 28
        } else if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            return 32
        } else if DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 33
        } else if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 34
        }
        return 30 // for iPhone 11
    }()
    
    static var TREBLE_TOP_OFFSET: CGFloat = {
        if (DeviceType.IS_IPHONE_6_6s_7_8)  {
            return 35.0
        }
        if (DeviceType.IS_IPHONE_6P_6sP_7P_8P_)  {
            return 15.0
        }
        if DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 15.0
        }
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 15.0
        }
        return 15.0 // for iPhone 11
    }()
    
    static var TREBLE_BOTTOM_OFFSET: CGFloat = {
        if(DeviceType.IS_IPHONE_6_6s_7_8) {
            return -16.0
        }
        if (DeviceType.IS_IPHONE_6P_6sP_7P_8P_) {
            return 6.0
        }
        if DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 9.0
        }
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 8.0
        }
        return 0 // for iPhone 11
    }()
    
    static let TREBLE_WIDTH: CGFloat = {
        if (DeviceType.IS_IPHONE_6_6s_7_8) {
            return 70.0
        }
        if (DeviceType.IS_IPHONE_6P_6sP_7P_8P_) {
            return 80.0
        }
        if DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 80.0
        }
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 89.0
        }
        
        return 80.0 // for iPhone 11
    }()
    
    static let TREBLE_LEFT_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            return 5.0
        }
        if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            return 8.0
        }
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 15.0
        }
        return 5.0
    }()
    
    static var BASS_TOP_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_6_6s_7_8 || DeviceType.IS_IPHONE_11Pro_X_Xs ||  DeviceType.IS_IPHONE_11_XR_11PMax_XsMax{
            return 6.0
        }
        if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            return 2.0
        }
        return 6.0
    }()
    static var BASS_LEFT_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            return 8.0
        }
        if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ || DeviceType.IS_IPHONE_11Pro_X_Xs ||  DeviceType.IS_IPHONE_11_XR_11PMax_XsMax{
            return 5.0
        }
        return 8.0
    }()
    static var BASS_BOTTOM_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_6_6s_7_8 || DeviceType.IS_IPHONE_11Pro_X_Xs ||  DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return -16.0
        }
        if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            return -15.0
        }
        return -16.0
    }()
    static var BASS_WIDTH: CGFloat = {
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            return 77.0
        }
        if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            return 87.0
        }
        if DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 95.0
        }
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 100.0
        }
        return 77.0
    }()
    
    static func viewHeight() -> Int {
        let linesThicknessHeight = Int(LINE_WIDTH)*5
        let linesOffset = LINE_OFFSET*4
        let offsetFromTopAndBottom = VERTICAL_OFFSET*2
        return (offsetFromTopAndBottom + linesOffset + linesThicknessHeight)
    }
    
    var notesArray:[NoteViewModel]?
    var pickedOutNotesIndexes:[Int] = [Int]() {
        didSet {
            delegate?.pickedOutNotesIndexesDidChange(newValue: notesRowValuesByIndexes(indexes: pickedOutNotesIndexes))
        }
    }
    
    var selectOnlyOneNote: Bool?
    var cleff: CleffTypes!
    
    //MARK: - Delegate
    var delegate: StaffViewDelegate?
    var noteDelegate: NoteViewModelDelegate?
    
    //MARK: -Views
    var previousSelectedNoteView: UIView?
    var selectedNoteView: UIView?
    
    var clefImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(notesViewModels:[NoteViewModel], selectOnlyOneNote: Bool, frame:CGRect, notesDelegate: NoteViewModelDelegate?, cleff: CleffTypes) {
        super.init(frame:frame)
        self.notesArray = notesViewModels
        self.selectOnlyOneNote = selectOnlyOneNote
        self.cleff = cleff
        setupView()
        if notesDelegate != nil {
            setNotesDelegate(deleg: notesDelegate!)
        }
    }
    
    init(cleff: CleffTypes, frame: CGRect) {
        super.init(frame:frame)
        self.cleff = cleff
        setupView()
    }
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLines(in: rect)
    }
    
    fileprivate func setupView() {
        let imageName = cleff == CleffTypes.Treble ? "trebleClef" : "bassClef"
        clefImageView.image = UIImage(named: imageName)
        
        let leftOffset = cleff == CleffTypes.Treble ? StaffView.TREBLE_LEFT_OFFSET : StaffView.BASS_LEFT_OFFSET
        let topOffset = cleff == CleffTypes.Treble ? StaffView.TREBLE_TOP_OFFSET : StaffView.BASS_TOP_OFFSET
        let bottomOffset = cleff == CleffTypes.Treble ? StaffView.TREBLE_BOTTOM_OFFSET : StaffView.BASS_BOTTOM_OFFSET
        let width =  cleff == CleffTypes.Treble ? StaffView.TREBLE_WIDTH : StaffView.BASS_WIDTH
        
        self.addSubview(clefImageView)
        clefImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftOffset).isActive = true
        clefImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: topOffset).isActive = true
        clefImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomOffset).isActive = true
        clefImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    fileprivate func setNotesDelegate(deleg: NoteViewModelDelegate) {
        self.noteDelegate = deleg
    }
    
    func drawPause(pause: PauseViewModel, viewWidth: CGFloat) {
        let width = cleff == CleffTypes.Treble ? viewWidth - StaffView.TREBLE_LEFT_OFFSET - StaffView.TREBLE_WIDTH : viewWidth - StaffView.BASS_LEFT_OFFSET - StaffView.BASS_WIDTH
        
        let pauseCenterX = width/2
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        let img = UIImage(named: pause.imageName)
        imageView.image = img
        
        let pausePositionY = pauseYPosition(pauseInnerOfsetFromCenter: pause.innerOffsetFromCenter)
    
        // расположение паузы
        self.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: clefImageView.rightAnchor, constant: pauseCenterX - pause.width/2 + 12).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: pause.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: pause.width).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: pausePositionY).isActive = true
    }

    func drawNotesOneByOne1(notesAreTransparent: Bool,viewWidth: CGFloat) {
        let width = cleff == CleffTypes.Treble ? viewWidth - StaffView.TREBLE_LEFT_OFFSET - StaffView.TREBLE_WIDTH : viewWidth - StaffView.BASS_LEFT_OFFSET - StaffView.BASS_WIDTH
       
        let noteCenterX = width/CGFloat(notesArray!.count+1)
        
        var i = 0
        for note in notesArray! {
            note.alfa = notesAreTransparent ? NoteViewModel.TRANSPARENT_ALFA : NoteViewModel.OPAQUE_ALFA
            note.delegate = noteDelegate
            let noteCharacteristics = note.noteImagesHeightsAndCentersPositions()
            let offsetFromCenterY = noteCharacteristics.durationCenterOffesetY
            
            // картинка для длительности ноты
            if note.model.duration != .none {
                let durationPositionY = noteYPosition(note: note, noteInnerOfsetFromCenter: offsetFromCenterY)
                
                let imageView = UIImageView()
                imageView.tag = i
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleAspectFit
                let img = UIImage(named: note.durationImageName)
                imageView.image = img
                imageView.alpha = note.alfa
                // расположение ноты
                self.addSubview(imageView)
                imageView.centerXAnchor.constraint(equalTo: clefImageView.rightAnchor, constant: noteCenterX*CGFloat(i+1) - note.durationWidth/2).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: note.durationHeight).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: note.durationWidth).isActive = true
                imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: durationPositionY).isActive = true
                
                //дополнительная линейка по центру ноты
                if note.additionalLine(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth) :  Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth)
                    drawAdditionalLine(
                        startX: Int(noteStartXPosition) - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY),
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY),
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                //дополнительная линейка снизу ноты
                if note.underline(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth) :  Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth)
                    drawAdditionalLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY) + StaffView.LINE_OFFSET/2,
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY) + StaffView.LINE_OFFSET/2,
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                //дополнительная линейка сверху ноты
                if note.upperLine(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth) :  Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth)
                    drawAdditionalLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET/2,
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET/2,
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                //дополнительная линейка над нотой
                if note.topAdditionalLine(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth) :  Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + noteCenterX*CGFloat(i+1) - note.durationWidth)
                    drawAdditionalLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET,
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET,
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                //Название ноты
                let nameLabel = UILabel()
                nameLabel.translatesAutoresizingMaskIntoConstraints = false
                nameLabel.font = NoteViewModel.NOTE_LABEL_FONT
                nameLabel.text = note.model.name.noteRusName()
                nameLabel.textColor = .black
                nameLabel.textAlignment = .center
                nameLabel.isHidden = !note.selected
                nameLabel.tag = i + 1000
                
                self.addSubview(nameLabel)
                nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
                nameLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
                nameLabel.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
                let range = (0...4)
                if (cleff == .Bass) && (range.contains(note.model.name.rawValue)) {
                    nameLabel.topAnchor.constraint(equalTo:imageView.bottomAnchor).isActive = true
                } else {
                nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: note.noteTitleBottomOffset(cleff: cleff)).isActive = true
                }
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(noteTapped(tapGestureRecognizer:)))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tapGestureRecognizer)
                
                //previousNoteWidth = noteWidth
                // TODO: если у ноты есть еще и тональность то отрисовать значок тональности в отдельной imageView
                if let toneImageName = noteCharacteristics.tone {
                }
            } else { //если просто тональность (без ноты)
                if let toneImageName = noteCharacteristics.tone,
                    let toneHeight = noteCharacteristics.toneHeight,
                    let toneWidth = noteCharacteristics.toneWidth,
                    let offsetFromCenterY = noteCharacteristics.toneCenterOffesetY {
                    
                    let durationPositionY = noteYPosition(note: note, noteInnerOfsetFromCenter: offsetFromCenterY)
                    let imageView = UIImageView()
                    //imageView.backgroundColor = .gray
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = UIImage(named: toneImageName)
                    // расположение тональности
                    self.addSubview(imageView)
                    //                    imageView.leftAnchor.constraint(equalTo: clefImageView.rightAnchor, constant:leftOffsetFromClef).isActive = true
                    //                    imageView.heightAnchor.constraint(equalToConstant: toneHeight).isActive = true
                    //                    imageView.widthAnchor.constraint(equalToConstant: toneWidth).isActive = true
                    //                    imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: durationPositionY).isActive = true
                    //                    previousLeftOffsetFromClef = leftOffsetFromClef
                    //previousNoteWidth = toneWidth
                }
            }
            i += 1
        }
    }
    
    
    func drawNotesOneByOne(notesAreTransparent: Bool) {
        let offsetBetwenNotes: CGFloat = {
            if DeviceType.IS_IPHONE_6_6s_7_8 {
                return 38.0
            }
            if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
                return 40.0
            }
            if DeviceType.IS_IPHONE_11Pro_X_Xs {
                return 38.0
            }
            if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
                return 40.0
            }
            return 38.0
        }()
        
        let offsetFromClef: CGFloat = {
            if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
                return 35.0
            } else {
                return 20.0
            }
        }()
        
        var previousNoteWidth: CGFloat = 0.0
        var previousLeftOffsetFromClef: CGFloat = 0.0
        
        var i = 0
        for note in notesArray! {
            note.alfa = notesAreTransparent ?  NoteViewModel.TRANSPARENT_ALFA : NoteViewModel.OPAQUE_ALFA
            note.delegate = noteDelegate
            let noteCharacteristics = note.noteImagesHeightsAndCentersPositions()
            let leftOffsetFromClef = i == 0 ? offsetFromClef : (previousLeftOffsetFromClef + previousNoteWidth + offsetBetwenNotes)
            let offsetFromCenterY = noteCharacteristics.durationCenterOffesetY
            
            // картинка для ноты
            if note.model.duration != .none { // если просто тональность
                let durationPositionY = noteYPosition(note: note, noteInnerOfsetFromCenter: offsetFromCenterY)
                let imageView = UIImageView()
                imageView.tag = i
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleAspectFit
                let img = UIImage(named: note.durationImageName)
                imageView.image = img
                imageView.alpha = note.alfa
                // расположение ноты
                self.addSubview(imageView)
                imageView.leftAnchor.constraint(equalTo: clefImageView.rightAnchor, constant:leftOffsetFromClef).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: note.durationHeight).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: note.durationWidth).isActive = true
                imageView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: durationPositionY).isActive = true
                
                //дополнительная линейка по центру ноты
                if note.additionalLine(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + leftOffsetFromClef) :
                        Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + leftOffsetFromClef)
                    drawAdditionalLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY),
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY),
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                //дополнительная линейка снизу ноты
                if note.underline(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + leftOffsetFromClef) :
                        Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + leftOffsetFromClef)
                    drawAdditionalLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY) + StaffView.LINE_OFFSET/2,
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY) + StaffView.LINE_OFFSET/2,
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                //дополнительная линейка сверху ноты "надчеркивание"
                if note.upperLine(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + leftOffsetFromClef) :
                        Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + leftOffsetFromClef)
                    drawAdditionalLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET/2,
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET/2,
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                //дополнительная линейка над нотой
                if note.upperLine(cleff: cleff) {
                    let addLineXOffset = 7
                    let noteStartXPosition = cleff == CleffTypes.Treble ? Int(StaffView.TREBLE_LEFT_OFFSET + StaffView.TREBLE_WIDTH + leftOffsetFromClef) :
                        Int(StaffView.BASS_LEFT_OFFSET + StaffView.BASS_WIDTH + leftOffsetFromClef)
                    drawAdditionalLine(
                        startX: noteStartXPosition - addLineXOffset,
                        toEndingX: Int(noteStartXPosition) + Int(note.durationWidth) + addLineXOffset,
                        startingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET,
                        toEndingY: StaffView.viewHeight() + Int(durationPositionY) - StaffView.LINE_OFFSET,
                        ofColor: .black,
                        widthOfLine: 3,
                        inView: self
                    )
                }
                
                //Название ноты
                let nameLabel = UILabel()
                nameLabel.translatesAutoresizingMaskIntoConstraints = false
                nameLabel.font = NoteViewModel.NOTE_LABEL_FONT
                nameLabel.text = note.model.name.noteRusName()
                nameLabel.textColor = .black
                nameLabel.textAlignment = .center
                nameLabel.isHidden = !note.selected
                nameLabel.tag = i + 1000
                
                self.addSubview(nameLabel)
                nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
                nameLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
                nameLabel.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
                let range = (0...4)
                if (cleff == .Bass) && (range.contains(note.model.name.rawValue)) {
                    nameLabel.topAnchor.constraint(equalTo:imageView.bottomAnchor).isActive = true
                } else {
                    nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: note.noteTitleBottomOffset(cleff: cleff)).isActive = true
                }
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(noteTapped(tapGestureRecognizer:)))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tapGestureRecognizer)
                
                previousLeftOffsetFromClef = leftOffsetFromClef
                previousNoteWidth = note.durationWidth
                // TODO: если у ноты есть еще и тональность то отрисовать значок тональности в отдельной imageView
                if let toneImageName = noteCharacteristics.tone {
                }
            } else { //если просто тональность (без ноты)
                if let toneImageName = noteCharacteristics.tone,
                    let toneHeight = noteCharacteristics.toneHeight,
                    let toneWidth = noteCharacteristics.toneWidth,
                    let offsetFromCenterY = noteCharacteristics.toneCenterOffesetY {
                    let durationPositionY = noteYPosition(note: note, noteInnerOfsetFromCenter: offsetFromCenterY)
                    
                    let imageView = UIImageView()
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
          
    //MARK - Actions
    @objc func noteTapped(tapGestureRecognizer:UITapGestureRecognizer) {
        selectedNoteView = tapGestureRecognizer.view
        let noteViewModelIndex = tapGestureRecognizer.view?.tag
        let noteViewModel = notesArray![noteViewModelIndex!]
        noteViewModel.didTapped(noteView:selectedNoteView!)
        
        if let selectOne = selectOnlyOneNote, selectOne == true{//можно выбрать только одну ноту из нескольких
            tapGestureRecognizer.view?.alpha = NoteViewModel.OPAQUE_ALFA
            if previousSelectedNoteView != nil, previousSelectedNoteView != tapGestureRecognizer.view {
                previousSelectedNoteView?.alpha = NoteViewModel.TRANSPARENT_ALFA
                for view in self.subviews { //имя предыдущей выбраной ноты скрываем
                    if view.tag == previousSelectedNoteView!.tag + 1000 {
                        view.isHidden = true
                    }
                }
            }
            if !pickedOutNotesIndexes.contains(noteViewModelIndex!) {
                pickedOutNotesIndexes.removeAll()
                pickedOutNotesIndexes.append(noteViewModelIndex!)
            }
            previousSelectedNoteView = tapGestureRecognizer.view
        } else {// можно выбрать несколько нот из нескольких
            tapGestureRecognizer.view?.alpha = noteViewModel.selected ? NoteViewModel.OPAQUE_ALFA : NoteViewModel.TRANSPARENT_ALFA
            
            if pickedOutNotesIndexes.contains(noteViewModelIndex!) {
                let index = pickedOutNotesIndexes.firstIndex(of: noteViewModelIndex!)
                pickedOutNotesIndexes.remove(at: index!)
            } else {
                pickedOutNotesIndexes.append(noteViewModelIndex!)
            }
        }
        showNoteName(notePosition:noteViewModelIndex!)
        print(pickedOutNotesIndexes)
    }
    
    //MARK - Private methods
    fileprivate func noteYPosition(note: NoteViewModel, noteInnerOfsetFromCenter: CGFloat) -> CGFloat{
        let offsetFromFirstLine = CGFloat(positionOnTheLine(note: note))/2.0 * CGFloat(StaffView.LINE_OFFSET)
        let durationPositionY = -CGFloat(StaffView.VERTICAL_OFFSET) - offsetFromFirstLine - noteInnerOfsetFromCenter
        return durationPositionY
    }
    
    fileprivate func positionOnTheLine(note: NoteViewModel) -> Int {
        let noteDoPosition = cleff == CleffTypes.Treble ? -2 : -4
        return noteDoPosition + note.model.name.rawValue
    }
    
    fileprivate func pauseYPosition(pauseInnerOfsetFromCenter: CGFloat) -> CGFloat{
        let positionOnTheLine: CGFloat = 4.0
        let offsetFromFirstLine = positionOnTheLine/2 * CGFloat(StaffView.LINE_OFFSET)
        let durationPositionY = -CGFloat(StaffView.VERTICAL_OFFSET) - offsetFromFirstLine - pauseInnerOfsetFromCenter
        return durationPositionY
    }
    
    fileprivate func showNoteName(notePosition:Int) {
        for view in self.subviews {
            if view.tag == notePosition + 1000 {//имя ноты
                view.isHidden = !view.isHidden
            }
        }
    }
    
    fileprivate func notesRowValuesByIndexes(indexes: [Int]) -> [Int] {
        var resultArray = [Int]()
        for i in indexes {
            let element = notesArray![i]
            resultArray.append(element.model.name.rawValue)
        }
        return resultArray
    }
    
    fileprivate func drawAdditionalLine(startX: Int, toEndingX endX: Int, startingY startY: Int, toEndingY endY: Int, ofColor lineColor: UIColor, widthOfLine lineWidth: CGFloat, inView view: UIView) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        view.layer.addSublayer(shapeLayer)
    }
    
    
    fileprivate func drawLines(in rect: CGRect) {
        let backgroundColor = UIColor.white
        backgroundColor.setFill()
        UIRectFill(rect)
        
        let lineStartX = 0
        let lineEndX = Int(rect.width)
        //
        var i = 0
        while i < 5 {
            let lineY = Int(rect.height) - StaffView.VERTICAL_OFFSET - i*StaffView.LINE_OFFSET
            drawLine(startX: lineStartX, toEndingX: lineEndX, startingY: lineY, toEndingY: lineY, ofColor: .black, widthOfLine: StaffView.LINE_WIDTH)
            i += 1
        }
    }
    
    fileprivate func drawLine(startX: Int, toEndingX endX: Int, startingY startY: Int, toEndingY endY: Int, ofColor lineColor: UIColor, widthOfLine lineWidth: CGFloat) {
        let color = UIColor.black
        color.setStroke()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        path.close()
        path.lineWidth = lineWidth
        path.stroke()
    }
}
