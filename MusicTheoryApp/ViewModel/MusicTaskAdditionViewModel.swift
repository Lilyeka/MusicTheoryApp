//
//  MusicTaskAdditionViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskAdditionViewModel {
    let model: MusicTaskAddition
    
    var notesVariables: [(NoteViewModel, MathSigns)]? {
        get {
            if model.variantsAreNotes {
                var resArray = [(NoteViewModel, MathSigns)]()
                for (duration,sign) in model.variables {
                    let noteModel = Note(duration: duration)
                    let noteViewModel = NoteViewModel(model: noteModel)
                    resArray.append((noteViewModel,sign))
                }
            }
            return nil
        }
    }
    var notesVariants: [NoteViewModel]? {
        get {
            if model.variantsAreNotes {
                var resArray = [NoteViewModel]()
                for duration in model.variants {
                    let noteModel = Note(duration: duration)
                    let noteViewModel = NoteViewModel(model: noteModel)
                    resArray.append(noteViewModel)
                }
                return resArray
            }
            return nil
        }
    }
    
    var pausesVariables: [(PauseViewModel, MathSigns)]? {
        get {
            if !model.variantsAreNotes {
                var resArray = [(PauseViewModel,MathSigns)]()
                for (duration, sign) in model.variables {
                    let pauseModel = Pause(duration: duration)
                    let pauseViewModel = PauseViewModel(model: pauseModel)
                    resArray.append((pauseViewModel,sign))
                }
                return resArray
            }
            return nil
        }
    }
    
    var pausesVariants: [PauseViewModel]? {
        get {
            if !model.variantsAreNotes {
                var resArray = [PauseViewModel]()
                for duration in model.variants {
                    let pauseModel = Pause(duration: duration)
                    let pauseViewModel = PauseViewModel(model: pauseModel)
                    resArray.append(pauseViewModel)
                }
                return resArray
            }
           return nil
        }
    }
    
    init(model: MusicTaskAddition) {
        self.model = model
    }
    
    func checkUserAnswers(userAnswer: Duration) -> Bool {
        return userAnswer == model.additionAnswer ? true : false
    }
    
}
