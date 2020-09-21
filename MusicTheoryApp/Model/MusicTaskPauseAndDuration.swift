//
//  MusicTaskPauseAndDuration.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTaskPauseAndDuration: MusicTask {
    var pause: Pause = Pause(duration: .whole)
    
    init(questionText: String, notesArray: [Note], cleff: CleffTypes, pause: Pause) {
        super.init(questionText: questionText, notesArray: notesArray, cleff: cleff)
        self.pause = pause
    }
    
}
