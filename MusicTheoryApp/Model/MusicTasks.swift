//
//  MusicTasks.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTasks: MusicTasksProtocol {
    static let shared = MusicTasks()
    var tasks: [MusicTask] = [
        /*  MusicTaskSelectNote(
            questionText: "Выберите ноты первой октавы, расположенные на основных линейках нотного стана",
            notesArray: [ Note(name:.Do, tone:.none, duration:.whole),
                          Note(name:.re, tone:.none, duration:.whole),
                          Note(name:.mi, tone:.none, duration:.whole),
                          Note(name:.fa, tone:.none, duration:.whole),
                          Note(name:.sol, tone:.none, duration:.whole),
                          Note(name:.la, tone:.none, duration:.whole),
                          Note(name:.si, tone:.none, duration:.whole)],
            rightAnswer:   [.mi,.sol,.si],
            cleff: CleffTypes.Treble),
        MusicTaskSelectNote(
            questionText: "Выберите ноты первой октавы, расположенные на основных линейках нотного стана",
            notesArray:[Note(name:.si, tone:.none, duration:.whole),
                        Note(name:.la, tone:.none, duration:.whole),
                        Note(name:.sol, tone:.none, duration:.whole),
                        Note(name:.fa, tone:.none, duration:.whole),
                        Note(name:.mi, tone:.none, duration:.whole),
                        Note(name:.re, tone:.none, duration:.whole),
                        Note(name:.Do, tone:.none, duration:.whole)],
            rightAnswer:   [.mi,.sol,.si],
            cleff: CleffTypes.Treble),
        MusicTaskSelectNote(
            questionText: "Выберите ноты второй октавы, расположенные на основных линейках нотного стана",
            notesArray: [ Note(name: .Do1, tone: .none, duration: .whole),
                          Note(name: .re1, tone: .none, duration: .whole),
                          Note(name: .mi1, tone: .none, duration: .whole),
                          Note(name: .fa1, tone: .none, duration: .whole),
                          Note(name: .sol1, tone: .none, duration: .whole),
                          Note(name: .la1, tone: .none, duration: .whole),
                          Note(name: .si1, tone: .none, duration: .whole)],
            rightAnswer: [.re1,.fa1],
            cleff: CleffTypes.Treble),
        MusicTaskSelectNote(
            questionText: "Выберите ноты второй октавы, расположенные на основных линейках нотного стана",
            notesArray: [Note(name: .si1, tone: .none, duration: .whole),
                         Note(name: .la1, tone: .none, duration: .whole),
                         Note(name: .sol1, tone: .none, duration: .whole),
                         Note(name: .fa1, tone: .none, duration: .whole),
                         Note(name: .mi1, tone: .none, duration: .whole),
                         Note(name: .re1, tone: .none, duration: .whole),
                         Note(name: .Do1, tone: .none, duration: .whole)],
            rightAnswer: [.re1,.fa1],
            cleff: CleffTypes.Treble),
        MusicTaskSelectNote(
            questionText: "Выберите ноты первой октавы, которые пишутся между линейками нотного стана",
            notesArray: [ Note(name:.Do, tone:.none, duration:.whole),
                          Note(name:.re, tone:.none, duration:.whole),
                          Note(name:.mi, tone:.none, duration:.whole),
                          Note(name:.fa, tone:.none, duration:.whole),
                          Note(name:.sol, tone:.none, duration:.whole),
                          Note(name:.la, tone:.none, duration:.whole),
                          Note(name:.si, tone:.none, duration:.whole)],
            rightAnswer: [.fa,.la],
            cleff: CleffTypes.Treble),
        MusicTaskSelectNote(
            questionText: "Выберите ноты первой октавы, которые пишутся между линейками нотного стана",
            notesArray:[Note(name:.si, tone:.none, duration:.whole),
                        Note(name:.la, tone:.none, duration:.whole),
                        Note(name:.sol, tone:.none, duration:.whole),
                        Note(name:.fa, tone:.none, duration:.whole),
                        Note(name:.mi, tone:.none, duration:.whole),
                        Note(name:.re, tone:.none, duration:.whole),
                        Note(name:.Do, tone:.none, duration:.whole)],
            rightAnswer: [.fa,.la],
            cleff: CleffTypes.Treble),
        MusicTaskSelectNote(
            questionText: "Выберите ноты второй октавы, которые пишутся между линейками нотного стана",
            notesArray: [ Note(name: .Do1, tone: .none, duration: .whole),
                          Note(name: .re1, tone: .none, duration: .whole),
                          Note(name: .mi1, tone: .none, duration: .whole),
                          Note(name: .fa1, tone: .none, duration: .whole),
                          Note(name: .sol1, tone: .none, duration: .whole),
                          Note(name: .la1, tone: .none, duration: .whole),
                          Note(name: .si1, tone: .none, duration: .whole)],
            rightAnswer: [.Do1,.mi1],
            cleff: CleffTypes.Treble),
        MusicTaskSelectNote(
            questionText: "Выберите ноты второй октавы, которые пишутся между линейками нотного стана",
            notesArray: [Note(name: .si1, tone: .none, duration: .whole),
                         Note(name: .la1, tone: .none, duration: .whole),
                         Note(name: .sol1, tone: .none, duration: .whole),
                         Note(name: .fa1, tone: .none, duration: .whole),
                         Note(name: .mi1, tone: .none, duration: .whole),
                         Note(name: .re1, tone: .none, duration: .whole),
                         Note(name: .Do1, tone: .none, duration: .whole)
            ],
            rightAnswer: [.Do1,.mi1],
            cleff: CleffTypes.Treble),
        MusicTaskShowNoteOnThePiano(questionText:"Нажмите на нужную ноту", note: Note(name:.fa, tone: .none, duration: .whole), cleff: CleffTypes.Treble),
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
                                  partsOfWord:[("Ли",nil),
                                               ("си",Note(name: .si, tone:.none, duration: .whole)),
                                               ("ца",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText:  "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
            ],
                                  partsOfWord: [("Ху",nil),
                                                ("до",Note(name:.Do, tone: .none, duration: .whole)),
                                                ("жник",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText:  "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
            ],
                                  partsOfWord: [("Зем",nil),
                                                ("ля",Note(name: .la, tone: .none, duration: .whole)),
                                                ("ника",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText:  "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
            ],
                                  partsOfWord: [("Ал",nil),
                                                ("фа",Note(name: .fa, tone: .none, duration: .whole)),
                                                ("вит",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText:  "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
            ],
                                  partsOfWord: [("Ось",nil),
                                                ("ми",Note(name: .mi, tone: .none, duration: .whole)),
                                                ("ног",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText:  "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
            ],
                                  partsOfWord: [("Ст",nil),
                                                ("ре",Note(name: .re, tone: .none, duration: .whole)),
                                                ("коза",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText:  "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
            ],
                                  partsOfWord: [
                                    ("Соль",Note(name: .sol, tone: .none, duration: .whole)),
                                    ("феджио",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText:  "Какая нота спряталась в слове?",
                                  notesArray: [
                                    Note(name:.Do, tone:.none, duration:.whole),
                                    Note(name:.re, tone:.none, duration:.whole),
                                    Note(name:.mi, tone:.none, duration:.whole),
                                    Note(name:.fa, tone:.none, duration:.whole),
                                    Note(name:.sol, tone:.none, duration:.whole),
                                    Note(name:.la, tone:.none, duration:.whole),
                                    Note(name:.si, tone:.none, duration:.whole)
            ],
                                  partsOfWord: [("Бе",nil),
                                                ("ре",Note(name: .re, tone: .none, duration: .whole)),
                                                ("г",nil)],
                                  needToType: false,
                                  cleff: CleffTypes.Treble),*/
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.si, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Cи",Note(name: .si, tone: .none, duration: .whole)),
                                    ("ница",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.re1, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Че",nil),
                                    ("ре",Note(name: .re1, tone: .none, duration: .whole)),
                                    ("паха",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.la, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Ля",Note(name: .la, tone: .none, duration: .whole)),
                                    ("гушка",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.fa1, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Фа",Note(name: .fa1, tone: .none, duration: .whole)),
                                    ("кел",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.Do1, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("До",Note(name: .Do1, tone: .none, duration: .whole)),
                                    ("рога",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.si, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Си",Note(name:.si, tone: .none, duration: .whole)),
                                    ("роп",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.mi, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Ми",Note(name:.mi, tone: .none, duration: .whole)),
                                    ("нута",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.mi1, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Пира",nil),
                                    ("ми",Note(name:.mi1, tone: .none, duration: .whole)),
                                    ("да",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.fa1, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Фа",Note(name:.fa1, tone: .none, duration: .whole)),
                                    ("нтазия",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble),
        MusicTaskSelectNoteInWord(questionText: "Разгадайте слово, зашифрованное с помощью нот",
                                  notesArray: [ Note(name:.la1, tone:.none, duration:.whole)],
                                  partsOfWord: [
                                    ("Свет",nil),
                                    ("ля",Note(name:.la1, tone: .none, duration: .whole)),
                                    ("чок",nil)],
                                  needToType: true,
                                  cleff: CleffTypes.Treble)
    ]
}
