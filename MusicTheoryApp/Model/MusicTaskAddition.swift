//
//  MusicTaskAddition.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 29.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

enum MathSigns {
    case addition
    case subtraction
}

class MusicTaskAddition: MusicTask {
    var additionAnswer: Duration!
    var variables: [(Duration,MathSigns?)]!
    var variants: [Duration]!
    var variantsAreNotes: Bool!
       
    init(questionText: String, answer: Duration, variables: [(Duration,MathSigns?)],
         variants: [Duration], variantsAreNotes: Bool) {
        super.init(questionText: questionText, notesArray: nil, cleff: CleffTypes.Treble)
        self.additionAnswer = answer
        self.variables = variables
        self.variants = variants
        self.variantsAreNotes = variantsAreNotes
    }
    
}
