//
//  MusicTaskPauseAndDurationViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskPauseAndDurationViewModel {
    
    let model: MusicTaskPauseAndDuration
   
    var pauseViewModel: PauseViewModel {
        get {
            return PauseViewModel(model: model.pause)
        }
    }
    
    var notesViewModels: [NoteViewModel] {
        get {
            var resultArray:[NoteViewModel] = [NoteViewModel]()
            for note in self.model.notesArray! {
                let noteViewModel = NoteViewModel(model:note)
                resultArray.append(noteViewModel)
            }
            return resultArray
        }
    }
    
    init(model:MusicTaskPauseAndDuration) {
        self.model = model
    }
    
    func checkUserAnswer(answer: Duration) -> Bool {
        let result = (answer == model.pause.duration)
        if result { model.didFinishTask(result: result) }
        return result
    }
    
    func noteDuration(noteIndex: Int) -> Duration {
        return notesViewModels[noteIndex].model.duration
    }
    
}
