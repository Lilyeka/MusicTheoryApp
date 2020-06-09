//
//  MusicTaskShowNoteOnThePiano.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskShowNoteOnThePiano: MusicTask {
 
    init(questionText: String, note: Note) {
        super.init(questionText: questionText, notesArray: [note])
    }
    

}
