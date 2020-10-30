//
//  MainRouter.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showQuizScene(article: QuizArticles) {
        let vc = QuizViewController()
        switch article {
        case .trebleCleffNotes:
            let musicTasks = MusicTasks()
            vc.questions = musicTasks.tasks
        case .bassCleffNotes:
            let musicTasksBass = MusicTasksBass()
            vc.questions = musicTasksBass.tasks
        case .durationsAndPauses:
            let musicTasksPauses = MusicTasksPausesDurations()
            vc.questions = musicTasksPauses.tasks
        }
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
