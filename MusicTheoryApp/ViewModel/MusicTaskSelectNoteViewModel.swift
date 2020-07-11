//
//  MusicTaskSelectNoteViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 05.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskSelectNoteViewModel {
    
    let model: MusicTaskSelectNote
    var notesViewModels: [NoteViewModel]
    
    
    init(model:MusicTaskSelectNote) {
        self.model = model
        
        var resultArray:[NoteViewModel] = [NoteViewModel]()
        for note in self.model.notesArray! {
            let noteViewModel = NoteViewModel(model:note)
            resultArray.append(noteViewModel)
        }
        self.notesViewModels = resultArray
    }
    
    func checkUserAnswer(userAnswer: Set<Int>) -> Bool {
        return model.rightAnswer == userAnswer ? true : false
    }
    
}
