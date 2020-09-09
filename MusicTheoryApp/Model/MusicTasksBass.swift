//
//  MusicTasksBass.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 05.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTasksBass {
    var tasks: [MusicTask] = [
        MusicTaskSelectNote(
            questionText: "Выберите ноты большой октавы, расположенные на основных линейках нотного стана",
            notesArray:[Note(name:.Do, tone:.none, duration:.whole),
                        Note(name:.re, tone:.none, duration:.whole),
                        Note(name:.mi, tone:.none, duration:.whole),
                        Note(name:.fa, tone:.none, duration:.whole),
                        Note(name:.sol, tone:.none, duration:.whole),
                        Note(name:.la, tone:.none, duration:.whole),
                        Note(name:.si, tone:.none, duration:.whole)],
            rightAnswer: [.sol, .si],
            cleff: CleffTypes.Bass),
        MusicTaskSelectNote(
                questionText: "Выберите ноты большой октавы, расположенные между линейками нотного стана",
                notesArray:[Note(name:.Do, tone:.none, duration:.whole),
                            Note(name:.re, tone:.none, duration:.whole),
                            Note(name:.mi, tone:.none, duration:.whole),
                            Note(name:.fa, tone:.none, duration:.whole),
                            Note(name:.sol, tone:.none, duration:.whole),
                            Note(name:.la, tone:.none, duration:.whole),
                            Note(name:.si, tone:.none, duration:.whole)],
                rightAnswer: [.la],
                cleff: CleffTypes.Bass),
        MusicTaskSelectNote(
            questionText: "Выберите ноты малой октавы, расположенные на основных линейках нотного стана",
            notesArray: [ Note(name: .Do1, tone: .none, duration: .whole),
                          Note(name: .re1, tone: .none, duration: .whole),
                          Note(name: .mi1, tone: .none, duration: .whole),
                          Note(name: .fa1, tone: .none, duration: .whole),
                          Note(name: .sol1, tone: .none, duration: .whole),
                          Note(name: .la1, tone: .none, duration: .whole),
                          Note(name: .si1, tone: .none, duration: .whole)],
            rightAnswer: [.re1, .fa1, .la1],
            cleff: CleffTypes.Bass),
        MusicTaskSelectNote(
            questionText: "Выберите ноты малой октавы, расположенные между линейками нотного стана",
            notesArray: [ Note(name: .Do1, tone: .none, duration: .whole),
                          Note(name: .re1, tone: .none, duration: .whole),
                          Note(name: .mi1, tone: .none, duration: .whole),
                          Note(name: .fa1, tone: .none, duration: .whole),
                          Note(name: .sol1, tone: .none, duration: .whole),
                          Note(name: .la1, tone: .none, duration: .whole),
                          Note(name: .si1, tone: .none, duration: .whole)],
            rightAnswer: [.Do1, .mi1, .sol1],
            cleff: CleffTypes.Bass),
        MusicTaskSelectNote(
            questionText: "Найдите все ноты ноты ФА большой и малой октавы",
            notesArray:[Note(name:.fa, tone:.none, duration:.whole),
                        Note(name:.mi1, tone:.none, duration:.whole),
                        Note(name:.fa1, tone:.none, duration:.whole),
                        Note(name:.Do1, tone:.none, duration:.whole),
                        Note(name:.sol, tone:.none, duration:.whole),
                        Note(name:.si, tone:.none, duration:.whole),
                        Note(name:.fa1, tone:.none, duration:.whole)],
            rightAnswer: [.fa, .fa1, .fa1],
            cleff: CleffTypes.Bass)
    ]
}
