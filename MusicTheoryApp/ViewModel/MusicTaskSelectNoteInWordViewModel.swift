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
        for partOfWord in model.partsOfWord! {
            if partOfWord.1! == userAnswer {
                return true
            }
        }
        return false
    }
    
    func checkUserAnswer1(userAnswer: [Int]) -> Bool {
        let userAnswerSet = Set(userAnswer)
        let notesInWordSet = notesInWord()
        return userAnswerSet == notesInWordSet ? true : false
    }
    
    func noteIsFromRightAnswer(note:Note.NoteName) -> Bool {
        let userAnswerSet = notesInWord()
        return userAnswerSet.contains(note.rawValue)
    }

    func notesAreInBigOctave() -> Bool {
        var notesAreLessThenSeven = notesViewModels.map({ (note) -> Bool in
               return note.model.name.rawValue < 7
           }).reduce(true){$0 && $1}
        
        return model.cleffType == .Bass && notesAreLessThenSeven ? true : false
    }
    
    fileprivate func notesInWord() -> Set<Int> {
        var notesInWordSet = Set<Int>()
        
        for partOfWord in model.partsOfWord! {
            if let note = partOfWord.1 {
                notesInWordSet.insert(note.name.rawValue)
            }
        }
        return notesInWordSet
    }
}
