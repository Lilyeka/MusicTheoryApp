//
//  Question.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 19.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

struct MusicTask {
    
    enum MusicTaskType {
        case SelectNotes
        case ColorNotes
    }
    
    var taskType: MusicTaskType
    var questionText: String
    var notesArray: [Note]?
    var rightAnswer: Set<Int>?
    
    init(taskType: MusicTaskType, questionText: String, notesArray: [Note], rightAnswer: Set<Int>) {
        self.taskType = taskType
        self.questionText = questionText
        self.notesArray = notesArray
        self.rightAnswer = rightAnswer
    }
    
    
    
}
