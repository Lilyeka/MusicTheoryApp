//
//  MusicTaskWriteNoteInWord.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 18.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskWriteNoteInWordViewModel {
    
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
    
    func checkUserAnswer(userAnswer:String) -> Bool {
        for partOfWord in model.partsOfWord! {
            if let part = partOfWord.1 {
                let noteName = part.name.noteRusName()
                if userAnswer.uppercased() == noteName.uppercased() {
                    model.didFinishTask(result: true)
                    return true
                }
            }
        }
        return false
    }
    
}
