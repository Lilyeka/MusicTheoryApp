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
        //TODO -
        // userAnswer должен быть массивом String т.к. есть слова где надо написать больше одной ноты
        // старнивать надо Uppercaserd строки т.к. пользователь не всегда пишет ответ с большой буквы
        for partOfWord in model.partsOfWord! {
            if let part = partOfWord.1 {
                if userAnswer == part.name.noteRusName() {return true}
            }
        }
        return false
    }
    
}
