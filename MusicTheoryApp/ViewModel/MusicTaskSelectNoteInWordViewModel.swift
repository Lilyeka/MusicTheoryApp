//
//  MusicTaskSelectNoteInWordViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskSelectNoteInWordViewModel {
    
    let model: MusicTaskSelectNoteInWord
    var notesViewModels: [NoteViewModel]
    
    init(model: MusicTaskSelectNoteInWord) {
        self.model = model
        
        var resultArray:[NoteViewModel] = [NoteViewModel]()
            for note in self.model.notesArray! {
                let noteViewModel = NoteViewModel(model:note)
                resultArray.append(noteViewModel)
            }
        self.notesViewModels = resultArray
    }
    
    func checkUserAnswer(userAnswer: Note) -> Bool {
        for partOfWord in model.partsOfAWord! {
            if partOfWord.1! == userAnswer {
                return true
            }
        }
        return false
    }
}
