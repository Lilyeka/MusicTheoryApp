//
//  MusicTasksPauses.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTasksPauses {
    var tasks: [MusicTask] = [
        MusicTaskPauseAndDuration(
            questionText: "Какая длительность соответствует данной паузе?",
            notesArray: [
                Note(name: .Do, tone: .none, duration: .quarter),
                Note(name: .Do, tone: .none, duration: .half),
                Note(name: .Do, tone: .none, duration: .whole),
                Note(name: .Do, tone: .none, duration: .eighth)],
            cleff: .Treble,
            pause: Pause(duration: .quarter))
    ]
}
