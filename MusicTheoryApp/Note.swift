//
//  Note.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

enum Duration {
    case whole //
    case half
    case quarter
    case eighth
}

enum NoteName: Int {
    case Do = -2
    case re = -1
    case mi = 0
    case fa = 1
    case sol = 2
    case la = 3
    case si = 4
}

enum Tonality {
    case dies
    case bimol
    case none
}

class Note {
    var name: NoteName = .Do
    var tone: Tonality = .none
    var duration: Duration = .whole
}
