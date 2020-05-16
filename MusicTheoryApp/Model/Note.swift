//
//  Note.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

struct Note {
     enum Duration {
        case whole
        case half
        case quarter
        case eighth
        case none //для значков нет длительности
    }
    
    public enum NoteName: Int {
        case Do = -2
        case re = -1
        case mi = 0
        case fa = 1
        case sol = 2
        case la = 3
        case si = 4
        case Do1 = 5
        case re1 = 6
        case mi1 = 7
        case fa1 = 8
        case sol1 = 9
        case la1 = 10
        case si1 = 11
    }

    public enum Tonality {
        case dies
        case bimol
        case none
    }
    
    var name: NoteName = .Do
    var tone: Tonality = .none
    var duration: Duration = .whole
    
//    static func ==(lhs: Note, rhs: Note) -> Bool {
//        return lhs.name == rhs.name && lhs.duration == rhs.duration && lhs.tone == rhs.tone
//    }
    
    init(name: NoteName, tone: Tonality, duration: Duration) {
        self.name = name
        self.tone = tone
        self.duration = duration
    }
}






