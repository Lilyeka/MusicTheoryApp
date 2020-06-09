//
//  PianoView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 25.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class WhiteKeyView: UIView {
    static let BORDER_LINE_THICKNESS: CGFloat = 5.0
    var notesForKey: [(Note.NoteName, Note.Tonality)]?
    
    init(frame: CGRect, notesForKey: [(Note.NoteName, Note.Tonality)]) {
        super.init(frame:frame)
        self.notesForKey = notesForKey
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.borderWidth = WhiteKeyView.BORDER_LINE_THICKNESS
        self.layer.borderColor = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
  }

class BlackKeyView: UIView {
    var notesForKey: [(Note.NoteName, Note.Tonality)]?
    
    init(frame: CGRect, notesForKey: [(Note.NoteName, Note.Tonality)]) {
        super.init(frame:frame)
        self.notesForKey = notesForKey
        self.backgroundColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

protocol PianoViewDelegate {
    func keyTapped(withNotes:[(Note.NoteName,Note.Tonality)])
}

class PianoView: UIView {
    var delegate: PianoViewDelegate?
    let WHITE_KEY_WIDTH: Double = 20.0
     
    let WHITE_KEYS_NUMBER: Int = 7
    let BLACK_KEYS_NUMBER: Int = 5
    
    var pickedOutNotes:[(Note.NoteName, Note.Tonality)]?
    
    var whiteKeysNotes: [[(Note.NoteName, Note.Tonality)]] = [
        [(.Do,.none),(.Do1,.none)],
        [(.re,.none),(.re1,.none)],
        [(.mi,.none),(.mi1,.none)],
        [(.fa,.none),(.fa1,.none)],
        [(.sol,.none),(.sol1,.none)],
        [(.la,.none),(.la1,.none)],
        [(.si,.none),(.si1,.none)]
    ]
    
    var blackKeysNotes:[[(Note.NoteName, Note.Tonality)]] = [
        [(.Do,.dies),(.Do1,.dies),(.re,.bimol),(.re1,.bimol)],
        [(.re,.dies),(.re1,.dies),(.mi,.bimol),(.mi1,.bimol)],
        [(.fa,.dies),(.fa1,.dies),(.sol,.bimol),(.sol1,.bimol)],
        [(.sol,.dies),(.sol1,.dies),(.la,.bimol),(.la1,.bimol)],
        [(.la,.dies),(.la1,.dies),(.si,.bimol),(.si1,.bimol)]
    ]
     
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(pianoWidth: CGFloat, blackKeysOffset: CGFloat, frame:CGRect) {
        super.init(frame:frame)
        let keyWidth:CGFloat = pianoWidth/CGFloat(WHITE_KEYS_NUMBER)
        setupView(keyWidth: keyWidth,blackKeysOffset: blackKeysOffset)
    }
    
    fileprivate func setupView(keyWidth:CGFloat, blackKeysOffset: CGFloat) {
        var i = 0
        var leftOffset:CGFloat = 0.0
        while i < WHITE_KEYS_NUMBER {
            let whiteKey = WhiteKeyView(frame: .zero, notesForKey: whiteKeysNotes[i])
            self.addSubview(whiteKey)
            whiteKey.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            whiteKey.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            whiteKey.widthAnchor.constraint(equalToConstant: keyWidth).isActive = true
            whiteKey.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftOffset).isActive = true
            leftOffset += keyWidth - 5.0
            i += 1
            setupTapWhiteKey(forView: whiteKey)
        }
        leftOffset = 0.0
        var j = 0
        var jj = 0
        while j < BLACK_KEYS_NUMBER + 1, jj < BLACK_KEYS_NUMBER {
            let blackKeyWidth = keyWidth - blackKeysOffset
            if j != 2 {
                let blackKey = BlackKeyView(frame: .zero, notesForKey: blackKeysNotes[jj])
                self.addSubview(blackKey)
                blackKey.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                blackKey.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
                blackKey.widthAnchor.constraint(equalToConstant: blackKeyWidth).isActive = true
                blackKey.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftOffset + keyWidth/2 + blackKeysOffset/2 - WhiteKeyView.BORDER_LINE_THICKNESS/2).isActive = true
                setupTapBlackKey(forView: blackKey)
            jj += 1
            }
            leftOffset += keyWidth - 5.0
            j += 1
        }
    }
    
    func setupTapWhiteKey(forView: UIView) {
        let touchDown = UILongPressGestureRecognizer(target:self, action: #selector(didTouchDownWhiteKey))
        touchDown.minimumPressDuration = 0
        forView.addGestureRecognizer(touchDown)
    }
    
    @objc func didTouchDownWhiteKey(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.view?.backgroundColor = .gray
        } else if gesture.state == .ended || gesture.state == .cancelled {
            gesture.view?.backgroundColor = .white
        }
        let view = gesture.view! as! WhiteKeyView
        delegate?.keyTapped(withNotes: view.notesForKey!)
        print(view.notesForKey!)
    }
    
    func setupTapBlackKey(forView: UIView) {
        let touchDown = UILongPressGestureRecognizer(target:self, action: #selector(didTouchDownBlackKey))
        touchDown.minimumPressDuration = 0
        forView.addGestureRecognizer(touchDown)
    }
    
    @objc func didTouchDownBlackKey(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.view?.backgroundColor = .gray
        } else if gesture.state == .ended || gesture.state == .cancelled {
            gesture.view?.backgroundColor = .black
        }
        let view = gesture.view! as! BlackKeyView
        delegate?.keyTapped(withNotes: view.notesForKey!)
        print(view.notesForKey!)
    }
}

