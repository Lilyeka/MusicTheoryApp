//
//  MainRouter.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController?

    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showQuizScene(article: QuizArticle) {
        let vc = QuizViewController()
        vc.questions = article.articleQuestions
        vc.numberOfFinishedTasks = article.numberOfFinishedTasks
        vc.delegate = self.viewController
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showStartAgainAlert(index: Int) {
        self.viewController?.showStartArticleAgainAlert(index: index)
    }
}
