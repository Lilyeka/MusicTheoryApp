//
//  Note.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

enum Octaves {
    case TrebleFirst
    case TrebleSecond
    case TrebleThird
    case BassBig
    case BassLittle
    case BassFirst
}

struct Note {
    enum Duration {
        case whole
        case half
        case quarter
        case eighth
        case none //для значков нет длительности
    }
    
    public enum NoteName: Int {
        case Do = 0
        case re = 1
        case mi = 2
        case fa = 3
        case sol = 4
        case la = 5
        case si = 6
        case Do1 = 7
        case re1 = 8
        case mi1 = 9
        case fa1 = 10
        case sol1 = 11
        case la1 = 12
        case si1 = 13
        case do2 = 14
        case re2 = 15
        case mi2 = 16
        
        func noteRusName() -> String {
            switch self {
            case .Do,.Do1,.do2:
                return "До"
            case .re,.re1,.re2:
                return "Ре"
            case .mi,.mi1,.mi2:
                return "Ми"
            case .fa,.fa1:
                return "Фа"
            case .sol, .sol1:
                return "Соль"
            case .la,.la1:
                return "Ля"
            case .si,.si1:
                return "Си"
            }
        }
    }
    
    public enum Tonality {
        case dies
        case bimol
        case none
    }
    
    var name: NoteName = .Do
    var tone: Tonality = .none
    var duration: Duration = .whole
    
    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.name == rhs.name && lhs.duration == rhs.duration && lhs.tone == rhs.tone
    }
    
    init(name: NoteName, tone: Tonality, duration: Duration) {
        self.name = name
        self.tone = tone
        self.duration = duration
    }
    
    func noteOctave() -> Octaves {
        switch self.name {
        case  .Do, .re, .mi, .fa, .sol, .la, .si:
            return Octaves.TrebleFirst
        case .Do1, .re1, .mi1, .fa1, .sol1, .la1, .si1:
            return Octaves.TrebleSecond
        default:
            return Octaves.TrebleFirst
        }
    }
}






