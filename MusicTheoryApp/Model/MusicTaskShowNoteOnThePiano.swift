//
//  MusicTaskShowNoteOnThePiano.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskShowNoteOnThePiano: MusicTask {
    /// это сделать частью PianoView
    var whiteKeysNotes: [[(Note.NoteName, Note.Tonality)]] = [
        [(.Do,.none),(.Do1,.none)],
        [(.re,.none),(.re1,.none)],
        [(.mi,.none),(.mi1,.none)],
        [(.fa,.none),(.fa1,.none)],
        [(.sol,.none),(.sol1,.none)],
        [(.la,.none),(.la1,.none)],
        [(.si,.none),(.si1,.none)]
    ]
    
    var blackKeysNotes:[[(Note.NoteName, Note.Tonality)]] = [
        [(.Do,.dies),(.Do1,.dies),(.re,.bimol),(.re1,.bimol)],
        [(.re,.dies),(.re1,.dies),(.mi,.bimol),(.mi1,.bimol)],
        [(.fa,.dies),(.fa1,.dies),(.sol,.bimol),(.sol1,.bimol)],
        [(.sol,.dies),(.sol1,.dies),(.la,.bimol),(.la1,.bimol)],
        [(.la,.dies),(.la1,.dies),(.si,.bimol),(.si1,.bimol)]
    ]
     //----------------->
    init(questionText: String, note: Note) {
        super.init(questionText: questionText, notesArray: [note])
    }
    
    func checkUserAnswer(userAnswer: (Note.NoteName, Note.Tonality)) -> Bool {
        return (self.notesArray![0].name, self.notesArray![0].tone) == userAnswer ? true : false
    }
}
