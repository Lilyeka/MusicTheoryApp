//
//  Question.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 19.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTask {
    var questionText: String
    var notesArray: [Note]?
    var cleffType: CleffTypes = CleffTypes.Treble
    var done: Bool = false
    
    init(questionText: String, notesArray: [Note]?, cleff:CleffTypes ) {
        self.questionText = questionText
        self.notesArray = notesArray
        self.cleffType = cleff
    }
}
