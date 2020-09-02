//
//  MusicTaskSelectNote.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 03.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskSelectNote: MusicTask {
    var rightAnswer: Set<Int>?
    
    init(questionText: String, notesArray: [Note], rightAnswer: Set<Int>, cleff: CleffTypes) {
        super.init(questionText: questionText, notesArray: notesArray, cleff: cleff)
        self.rightAnswer = rightAnswer
    }
    

}
