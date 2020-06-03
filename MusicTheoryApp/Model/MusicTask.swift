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
  
    
    init(questionText: String, notesArray: [Note]) {
        self.questionText = questionText
        self.notesArray = notesArray
    }
    
}
