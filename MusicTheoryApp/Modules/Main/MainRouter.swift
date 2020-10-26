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
    
    func showQuizScene(articleNumber: Int) {
      //  MusicTasksPausesDurations()/*MusicTasks()*//* MusicTasksBass()*/
        let vc = QuizViewController()
        switch articleNumber {
        case 0:
            let musicTasks = MusicTasks()
            vc.questions = musicTasks.tasks
        case 1:
            let musicTasksBass = MusicTasksBass()
            vc.questions = musicTasksBass.tasks
        case 2:
            let musicTasksPauses = MusicTasksPausesDurations()
            vc.questions = musicTasksPauses.tasks
        default:
            break
        }
        self.viewController.navigationController?.pushViewController(vc, animated: true)

    }
}
