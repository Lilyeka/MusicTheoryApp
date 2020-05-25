//
//  PianoView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 25.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class WhiteKeyView: UIView {
    let BORDER_LINE_THICKNESS: CGFloat = 5.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = BORDER_LINE_THICKNESS
        self.layer.borderColor = CGColor(srgbRed: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
     
  }

class PianoView: UIView {
    let WHITE_KEY_WIDTH: Double = 20.0
    let WHITE_KEYS_NUMBER: Int = 7
    let BLACK_KEYS_NUMBER: Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(pianoWidth: CGFloat, frame:CGRect) {
        super.init(frame:frame)
        var keyWidth = pianoWidth/CGFloat(WHITE_KEYS_NUMBER)
        setupView(keyWidth:keyWidth)
    }
    
    fileprivate func setupView(keyWidth:CGFloat) {
        var i = 0
        var leftOffset:CGFloat = 0.0
        while i < WHITE_KEYS_NUMBER {
            let whiteKey = WhiteKeyView()
            whiteKey.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(whiteKey)
            whiteKey.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            whiteKey.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            whiteKey.widthAnchor.constraint(equalToConstant: keyWidth).isActive = true
            whiteKey.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftOffset).isActive = true
            leftOffset += keyWidth
            i += 1
        }
    }
}

