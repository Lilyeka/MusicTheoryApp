//
//  MathSign.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 15.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

enum MathSigns {
    case addition
    case subtraction
    case equation
    case question
}

class MathSign {
    var sign: MathSigns
    
    init(sign: MathSigns) {
        self.sign = sign
    }
}


