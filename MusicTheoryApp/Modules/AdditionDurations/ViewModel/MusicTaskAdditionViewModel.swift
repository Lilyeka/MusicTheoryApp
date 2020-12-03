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
    
    var mathElements:[MathElementViewModel] {
        get {
            var resArray = [MathElementViewModel]()
            for (duration,sign) in model.variables {
                if let duration = duration {
                    if model.variantsAreNotes {
                        let noteModel = Note(duration: duration)
                        let noteViewModel = NoteViewModel(model: noteModel)
                        resArray.append(noteViewModel)
                    } else {
                        let pauseModel = Pause(duration: duration)
                        let pauseViewModel = PauseViewModelSeparate(model: pauseModel)
                        resArray.append(pauseViewModel)
                    }
                }
                if let sign = sign {
                    resArray.append(MathSignViewModel(model: sign))
                }
            }
            return resArray
        }
    }
    
    var notesVariables: [(NoteViewModel?, MathSignViewModel)]? {
        get {
            if model.variantsAreNotes {
                var resArray = [(NoteViewModel?, MathSignViewModel)]()
                for (duration,sign) in model.variables {
                    let noteModel:Note?
                    var noteViewModel: NoteViewModel? = nil
                    if let duration = duration {
                        noteModel = Note(duration: duration)
                        noteViewModel = NoteViewModel(model: noteModel!)
                    }
                    if let sign = sign {
                        resArray.append((noteViewModel,MathSignViewModel(model: sign)))
                    }
                }
                return resArray
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
    
    var pausesVariables: [(PauseViewModelSeparate?, MathSignViewModel)]? {
        get {
            if !model.variantsAreNotes {
                var resArray = [(PauseViewModelSeparate?,MathSignViewModel)]()
                for (duration, sign) in model.variables {
                    let pauseModel:Pause?
                    var pauseViewModel: PauseViewModelSeparate? = nil
                    if let duration = duration {
                        pauseModel = Pause(duration: duration)
                        pauseViewModel = PauseViewModelSeparate(model: pauseModel!)
                    }
                    if let sign = sign {
                        resArray.append((pauseViewModel,MathSignViewModel(model: sign)))
                    }
                }
                return resArray
            }
            return nil
        }
    }
    
    var pausesVariants: [PauseViewModelSeparate]? {
        get {
            if !model.variantsAreNotes {
                var resArray = [PauseViewModelSeparate]()
                for duration in model.variants {
                    let pauseModel = Pause(duration: duration)
                    let pauseViewModel = PauseViewModelSeparate(model: pauseModel)
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
    
    func checkUserAnswer(userAnswer: Duration) -> Bool {
        let result = (userAnswer == model.rightAnswer)
        model.done = result
        return result
    }
    
    func getQuestionText() -> String {
        return model.questionText
    }
}
