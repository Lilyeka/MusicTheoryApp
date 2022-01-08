//
//  MusicTaskShowNoteOnThePianoViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 08.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskShowNoteOnThePianoViewModel {
    
    let model: MusicTaskShowNoteOnThePiano
    var notesViewModels: [NoteViewModel]
    
    init(model:MusicTaskShowNoteOnThePiano) {
        self.model = model
        
        var resultArray:[NoteViewModel] = [NoteViewModel]()
        for note in self.model.notesArray! {
            let noteViewModel = NoteViewModel(model:note)
            resultArray.append(noteViewModel)
        }
        self.notesViewModels = resultArray
    }
    
    func checkUserAnswer(userAnswer: [(Note.NoteName, Note.Tonality)]) -> Bool {
        let noteName = model.notesArray![0].name
        let noteTone = model.notesArray![0].tone
        for noteNameAndTone in userAnswer {
            if noteNameAndTone.0 == noteName && noteNameAndTone.1 == noteTone {
                return true
            }
        }
        return false
    }
}
