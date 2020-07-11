//
//  QuizRouter.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 09.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class QuizRouter: QuizRouterProtocol {
    weak var viewController: QuizViewController!
    
    init(viewController: QuizViewController) {
        self.viewController = viewController
    }
}
