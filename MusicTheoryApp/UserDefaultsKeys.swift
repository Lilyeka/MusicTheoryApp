//
//  UserDefaultsKeys.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.01.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import Foundation

enum ArticleResultsAndKeys: String {
    case firstArticleDoneTasksNumber = "first_article_done_tasks"
    case secondArticleDoneTasksNumber = "second_article_done_tasks"
    case thirdArticleDoneTasksNumber = "third_article_done_tasks"
    
    var title: String {
        switch self {
        case .firstArticleDoneTasksNumber:
            return "Ноты в скрипичном ключе"
        case .secondArticleDoneTasksNumber:
            return "Ноты в басовом ключе"
        case .thirdArticleDoneTasksNumber:
            return "Длительности и паузы"
        }
    }
    
    
    func  getDoneTasks() -> Int {
        switch self {
        case .firstArticleDoneTasksNumber:
            return UserDefaults.standard.integer(forKey: ArticleResultsAndKeys.firstArticleDoneTasksNumber.rawValue)
        case .secondArticleDoneTasksNumber:
            return UserDefaults.standard.integer(forKey: ArticleResultsAndKeys.secondArticleDoneTasksNumber.rawValue)
        case .thirdArticleDoneTasksNumber:
             return UserDefaults.standard.integer(forKey: ArticleResultsAndKeys.thirdArticleDoneTasksNumber.rawValue)
        }
    }
}

