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
    
//    func checkUserAnswer(userAnswer: Note) -> Bool {
//        for partOfWord in model.partsOfWord! {
//            if partOfWord.1! == userAnswer {
//                return true
//            }
//        }
//        return false
//    }
    
    func checkUserAnswer1(userAnswer: [Int]) -> Bool {
        let userAnswerSet = Set(userAnswer)
        let notesInWordSet = notesInWord()
        let result = (userAnswerSet == notesInWordSet)
        return result
    }
    
    func noteIsFromRightAnswer(note:Note.NoteName) -> Bool {
        let userAnswerSet = notesInWord()
        return userAnswerSet.contains(note.rawValue)
    }

    func staffViewBigOctaveBottomOffset() -> CGFloat {
        var notesAreLessThenSeven = notesViewModels.map({ (note) -> Bool in
               return note.model.name.rawValue < 7
           }).reduce(true){ $0 && $1 }
        
        if notesAreLessThenSeven {
            if DeviceType.IS_IPHONE_11Pro_X_Xs {
                return -20.0
            }
       
            if (DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_6_6s_7_8 || DeviceType.IS_IPHONE_6P_6sP_7P_8P_) {
                return -40.0
            }
            if DeviceType.IS_IPHONE_12_12Pro_13_13Pro || DeviceType.IS_IPHONE_12ProMax_13ProMax {
                return -60.0
            }
        }
        return 0.0
    }
    
    fileprivate func notesInWord() -> Set<Int> {
        var notesInWordSet = Set<Int>()
        
        for partOfWord in model.partsOfWord {
            if let note = partOfWord.1 {
                notesInWordSet.insert(note.name.rawValue)
            }
        }
        return notesInWordSet
    }
}
