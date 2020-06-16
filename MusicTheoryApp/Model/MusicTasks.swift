//
//  MusicTasks.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTasks {
    var tasks: [MusicTask] = [
        MusicTaskSelectNote(
            questionText: "Выберите ноты 1-й октавы, расположенные на основных линейках нотного стана",
            notesArray: [ Note(name:.Do, tone:.none, duration:.whole),
                          Note(name:.re, tone:.none, duration:.whole),
                          Note(name:.mi, tone:.none, duration:.whole),
                          Note(name:.fa, tone:.none, duration:.whole),
                          Note(name:.sol, tone:.none, duration:.whole),
                          Note(name:.la, tone:.none, duration:.whole),
                          Note(name:.si, tone:.none, duration:.whole)],
            rightAnswer:   [2,4,6]),
        MusicTaskSelectNote(
            questionText: "Выберите ноты 1-й октавы, расположенные на основных линейках нотного стана",
            notesArray:[Note(name:.si, tone:.none, duration:.whole),
                        Note(name:.la, tone:.none, duration:.whole),
                        Note(name:.sol, tone:.none, duration:.whole),
                        Note(name:.fa, tone:.none, duration:.whole),
                        Note(name:.mi, tone:.none, duration:.whole),
                        Note(name:.re, tone:.none, duration:.whole),
                        Note(name:.Do, tone:.none, duration:.whole)],
            rightAnswer:   [2,4,6]),
        MusicTaskSelectNote(
            questionText: "Выберите ноты 2-й октавы, расположенные на основных линейках нотного стана",
            notesArray: [ Note(name: .Do1, tone: .none, duration: .whole),
                          Note(name: .re1, tone: .none, duration: .whole),
                          Note(name: .mi1, tone: .none, duration: .whole),
                          Note(name: .fa1, tone: .none, duration: .whole),
                          Note(name: .sol1, tone: .none, duration: .whole),
                          Note(name: .la1, tone: .none, duration: .whole),
                          Note(name: .si1, tone: .none, duration: .whole)],
            rightAnswer: [8,10]),
        MusicTaskSelectNote(
            questionText: "Выберите ноты 2-й октавы, расположенные на основных линейках нотного стана",
            notesArray: [Note(name: .si1, tone: .none, duration: .whole),
                         Note(name: .la1, tone: .none, duration: .whole),
                         Note(name: .sol1, tone: .none, duration: .whole),
                         Note(name: .fa1, tone: .none, duration: .whole),
                         Note(name: .mi1, tone: .none, duration: .whole),
                         Note(name: .re1, tone: .none, duration: .whole),
                         Note(name: .Do1, tone: .none, duration: .whole)
            ],
            rightAnswer: [8,10]),
        MusicTaskSelectNote(
            questionText: "Выберите ноты 1-й октавы, которые пишутся между линейками нотного стана",
            notesArray: [ Note(name:.Do, tone:.none, duration:.whole),
                          Note(name:.re, tone:.none, duration:.whole),
                          Note(name:.mi, tone:.none, duration:.whole),
                          Note(name:.fa, tone:.none, duration:.whole),
                          Note(name:.sol, tone:.none, duration:.whole),
                          Note(name:.la, tone:.none, duration:.whole),
                          Note(name:.si, tone:.none, duration:.whole)],
            rightAnswer:   [1,3,5]),
        MusicTaskSelectNote(
            questionText: "Выберите ноты 1-й октавы, которые пишутся между линейками нотного стана",
            notesArray:[Note(name:.si, tone:.none, duration:.whole),
                        Note(name:.la, tone:.none, duration:.whole),
                        Note(name:.sol, tone:.none, duration:.whole),
                        Note(name:.fa, tone:.none, duration:.whole),
                        Note(name:.mi, tone:.none, duration:.whole),
                        Note(name:.re, tone:.none, duration:.whole),
                        Note(name:.Do, tone:.none, duration:.whole)],
            rightAnswer:   [1,3,5]),
        MusicTaskSelectNote(
            questionText: "Выберите ноты 2-й октавы, которые пишутся между линейками нотного стана",
            notesArray: [ Note(name: .Do1, tone: .none, duration: .whole),
                          Note(name: .re1, tone: .none, duration: .whole),
                          Note(name: .mi1, tone: .none, duration: .whole),
                          Note(name: .fa1, tone: .none, duration: .whole),
                          Note(name: .sol1, tone: .none, duration: .whole),
                          Note(name: .la1, tone: .none, duration: .whole),
                          Note(name: .si1, tone: .none, duration: .whole)],
            rightAnswer: [5,7]),
        MusicTaskSelectNote(
            questionText: "Выберите ноты 2-й октавы, которые пишутся между линейками нотного стана",
            notesArray: [Note(name: .si1, tone: .none, duration: .whole),
                         Note(name: .la1, tone: .none, duration: .whole),
                         Note(name: .sol1, tone: .none, duration: .whole),
                         Note(name: .fa1, tone: .none, duration: .whole),
                         Note(name: .mi1, tone: .none, duration: .whole),
                         Note(name: .re1, tone: .none, duration: .whole),
                         Note(name: .Do1, tone: .none, duration: .whole)
            ],
            rightAnswer: [5,7]),
        MusicTaskShowNoteOnThePiano(questionText:"Нажмите на нужную ноту", note: Note(name:.fa, tone: .none, duration: .whole)),
        MusicTaskSelectNoteInWord(questionText: "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
                                   ],
                                  partsOfAWord:[("Ли",nil),
                                                ("си",Note(name: .si, tone:.none, duration: .whole)),
                                                ("ца",nil)])
    ]
}
