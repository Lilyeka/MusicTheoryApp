//
//  MusicTaskShowNoteOnThePianoViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 08.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskShowtNoteOnThePianoViewModel {

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
        //TODO - сделать настоящую проверку вродит ли ноты из модели в массив нот клавиши
        
       // if userAnswer.contains((model.notesArray![0].name, model.notesArray![0].tone)) {
            
       // }
          return true //(model.notesArray![0].name, model.notesArray![0].tone) in userAnswer ? true : false
      }
    
}
