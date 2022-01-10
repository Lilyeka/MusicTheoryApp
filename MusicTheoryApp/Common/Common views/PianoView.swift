//
//  PianoView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 25.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit
class PianoKeyView: UIView {
    var fireworkView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addFireworkSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addFireworkSubView() {
        self.fireworkView = UIView()
        self.fireworkView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.fireworkView)
        NSLayoutConstraint.activate([
            self.fireworkView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.fireworkView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0),
            self.fireworkView.widthAnchor.constraint(equalToConstant: 2.0),
            self.fireworkView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }
}

class WhiteKeyView: PianoKeyView {
    static let BORDER_LINE_THICKNESS: CGFloat = 5.0
    var notesForKey: [(Note.NoteName, Note.Tonality)]
    
    init(notesForKey: [(Note.NoteName, Note.Tonality)]) {
        self.notesForKey = notesForKey
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.borderWidth = WhiteKeyView.BORDER_LINE_THICKNESS
        self.layer.borderColor = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
     }
        
     required init?(coder aDecoder: NSCoder) {
        return nil
     }
  }

class BlackKeyView: PianoKeyView {
    var notesForKey: [(Note.NoteName, Note.Tonality)]
    
    init(notesForKey: [(Note.NoteName, Note.Tonality)]) {
        self.notesForKey = notesForKey
        super.init(frame: .zero)
        self.backgroundColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

protocol PianoViewDelegate {
    func keyTapped(withNotes:[(Note.NoteName,Note.Tonality)], view: PianoKeyView)
}

class PianoView: UIView {
    var delegate: PianoViewDelegate?
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
    
    init(pianoWidth: CGFloat, blackKeysOffset: CGFloat, delegate: PianoViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        let keyWidth:CGFloat = pianoWidth/CGFloat(WHITE_KEYS_NUMBER)
        self.setupView(keyWidth: keyWidth, blackKeysOffset: blackKeysOffset)
    }
    
    fileprivate func setupView(keyWidth: CGFloat, blackKeysOffset: CGFloat) {
        var i = 0
        var leftOffset:CGFloat = 0.0
        while i < WHITE_KEYS_NUMBER {
            let whiteKey = WhiteKeyView(notesForKey: whiteKeysNotes[i])
            self.addSubview(whiteKey)
            whiteKey.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            whiteKey.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
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
            if j != 2 { // рисуем черные клавиши подряд,третьей быть не должно
                let blackKey = BlackKeyView(notesForKey: blackKeysNotes[jj])
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
        let touchDown = UILongPressGestureRecognizer(target: self, action: #selector(didTouchDownWhiteKey))
        touchDown.minimumPressDuration = 0
        forView.addGestureRecognizer(touchDown)
    }
    
    @objc func didTouchDownWhiteKey(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.0, animations: {
                gesture.view?.layer.backgroundColor = UIColor.gray.cgColor
                self.isUserInteractionEnabled = false
            })
        } else if gesture.state == .ended || gesture.state == .cancelled {
            UIView.animate(withDuration: 0.1, animations: {
                gesture.view?.layer.backgroundColor = UIColor.white.cgColor
            }) { _ in
                if let view = gesture.view as? WhiteKeyView {
                    self.delegate?.keyTapped(withNotes: view.notesForKey, view: view)
                    self.isUserInteractionEnabled = true
                    print(view.notesForKey)
                }
            }
        }
    }
    
    func setupTapBlackKey(forView: UIView) {
        let touchDown = UILongPressGestureRecognizer(target:self, action: #selector(didTouchDownBlackKey))
        touchDown.minimumPressDuration = 0
        forView.addGestureRecognizer(touchDown)
    }
    
    @objc func didTouchDownBlackKey(gesture: UILongPressGestureRecognizer) {
         if gesture.state == .began {
            UIView.animate(withDuration: 0.0, animations: {
                gesture.view?.layer.backgroundColor = UIColor.gray.cgColor
                self.isUserInteractionEnabled = false
            })
        } else if gesture.state == .ended || gesture.state == .cancelled {
            UIView.animate(withDuration: 0.5, animations: {
                gesture.view?.layer.backgroundColor = UIColor.black.cgColor
            }) { _ in
                    let view = gesture.view! as! BlackKeyView
                    self.delegate?.keyTapped(withNotes: view.notesForKey,view:view)
                    self.isUserInteractionEnabled = true
                    print(view.notesForKey)
            }
        }
    }
}

