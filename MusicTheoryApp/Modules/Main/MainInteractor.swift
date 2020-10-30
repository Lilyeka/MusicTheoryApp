//
//  MainInteractor.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

enum QuizArticles: String {
    case trebleCleffNotes = "Ноты в скрипичном ключе"
    case bassCleffNotes = "Ноты в басовом ключе"
    case durationsAndPauses = "Длительности и паузы"
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol!
    var arrayOfArticles: [QuizArticles] {
        get {// TODO: need return from service!
            return [.trebleCleffNotes, .bassCleffNotes, .durationsAndPauses]
        }
    }
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
}
