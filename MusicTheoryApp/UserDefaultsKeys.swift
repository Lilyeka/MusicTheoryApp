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
    
    func getDoneTasks() -> Int {
        UserDefaults.standard.integer(forKey: self.rawValue)
    }
    
    func clearDoneTasks() {
        UserDefaults.standard.removeObject(forKey: self.rawValue)
    }
}

