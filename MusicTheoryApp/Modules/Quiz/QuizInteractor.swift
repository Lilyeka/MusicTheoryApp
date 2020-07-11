//
//  QuizInteractor.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 09.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class QuizInteractor: QuizInteractorProtocol {
    weak var presenter: QuizPresenterProtocol!
 
    
    //let currencyService: CurrencyServiceProtocol = CurrencyService()
    // let serverService: ServerServiceProtocol = ServerService()
    
    //var currencyChangingMode: CurrencyChangingMode?
    
    required init(presenter: QuizPresenterProtocol) {
        self.presenter = presenter
    }
}
