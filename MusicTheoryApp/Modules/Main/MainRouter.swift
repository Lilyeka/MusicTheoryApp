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
        if articleNumber == 0 {
            print("Открыть экран с первым квизом!")
            let vc = QuizViewController()
            self.viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
