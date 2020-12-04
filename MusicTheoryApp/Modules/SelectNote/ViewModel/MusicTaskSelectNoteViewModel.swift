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
    
    func checkUserAnswer(userAnswer: [Note.NoteName]) -> Bool {
        let sortedUserAnswer = userAnswer.sorted{$0.rawValue < $1.rawValue}
        let sortedRightAnswer = model.rightAnswer?.sorted{$0.rawValue < $1.rawValue}
        let result = (sortedRightAnswer == sortedUserAnswer)
        if result { model.didFinishTask(result: result) }
        return result
    }
    
    func noteIsFromRightAnswer(note: Note.NoteName) -> Bool {
        for n in model.rightAnswer! {
            if n == note {return true}
        }
        return false
    }
    
    func notesOctave() -> Octaves? {
        var octavesSet = Set<Octaves>()
        for n in self.model.notesArray! {
            octavesSet.insert(n.noteOctave())
        }
        if octavesSet.count == 1 {
            return octavesSet.popFirst()!
        }
        return nil
    }
}
