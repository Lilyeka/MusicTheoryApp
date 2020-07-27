//
//  QuizConfigurator.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 09.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizConfigurator: QuizConfiguratorProtocol {
    func configure(with viewController: QuizViewController) {
        let presenter = QuizPresenter(view: viewController)
        let interactor = QuizInteractor(presenter: presenter)
        let router = QuizRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}
