//
//  QuizProtocols.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 09.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

protocol QuizConfiguratorProtocol: AnyObject {
    func configure(with viewController: QuizViewController)
}

protocol QuizViewProtocol: AnyObject {
    var presenter: QuizPresenterProtocol! {get set}
}

protocol QuizPresenterProtocol: AnyObject {
    var router: QuizRouterProtocol! {get set}
    var interactor: QuizInteractorProtocol! {get set}
    
    func viewForQuizQuestion(number: Int)
}

protocol QuizInteractorProtocol: AnyObject {
    
}

protocol QuizRouterProtocol:AnyObject {
    
}


