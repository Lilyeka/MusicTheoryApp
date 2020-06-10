//
//  MusicTaskSelectNoteInWord.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 10.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskSelectNoteInWord: MusicTask {
    var partsOfAWord:[(String,Note?)]?
    
    init(questionText: String, notesArray: [Note], partsOfAWord:[(String,Note?)]) {
        super.init(questionText: questionText, notesArray: notesArray)
        self.partsOfAWord = partsOfAWord
    }
    
}
