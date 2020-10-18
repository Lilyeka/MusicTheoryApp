//
//  MusicTaskAddition.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 29.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskAddition: MusicTask {
    var rightAnswer: Duration!
    var variables: [(Duration?,MathSign?)]!
    var variants: [Duration]!
    var variantsAreNotes: Bool!
       
    init(questionText: String, answer: Duration, variables: [(Duration?,MathSign?)],
         variants: [Duration], variantsAreNotes: Bool) {
        super.init(questionText: questionText, notesArray: nil, cleff: CleffTypes.Treble)
        self.rightAnswer = answer
        self.variables = variables
        self.variants = variants
        self.variantsAreNotes = variantsAreNotes
    }
    
}
