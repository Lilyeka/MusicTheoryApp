//
//  MusicTaskSelectNoteInWord.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 10.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskSelectNoteInWord: MusicTask {
    var partsOfWord:[(String,Note?)]?
    var needToTypeAnswer: Bool?
    
    init(questionText: String, notesArray: [Note], partsOfWord:[(String,Note?)], needToType: Bool) {
        super.init(questionText: questionText, notesArray: notesArray)
        self.partsOfWord = partsOfWord
        self.needToTypeAnswer = needToType
    }
    
}
