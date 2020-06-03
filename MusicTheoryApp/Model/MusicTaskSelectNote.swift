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
    
    init(questionText: String, notesArray: [Note], rightAnswer: Set<Int>) {
        super.init(questionText: questionText, notesArray: notesArray)
        self.rightAnswer = rightAnswer
    }
    
    func checkUserAnswer(userAnswer: Set<Int>) -> Bool {
        return self.rightAnswer == userAnswer ? true : false
    }
}
