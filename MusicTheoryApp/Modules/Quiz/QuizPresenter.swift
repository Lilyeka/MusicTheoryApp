//
//  QuizPresenter.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 09.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class QuizPresenter: QuizPresenterProtocol {
    weak var view: QuizViewProtocol!
    var interactor: QuizInteractorProtocol!
    var router: QuizRouterProtocol!
    
    required init(view: QuizViewProtocol) {
        self.view = view
    }
    
    func viewForQuizQuestion(number: Int) {
        
    }
}
