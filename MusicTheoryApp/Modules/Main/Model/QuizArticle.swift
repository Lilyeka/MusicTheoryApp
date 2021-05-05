//
//  QuizArticles.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 02.12.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

enum QuizArticles: String {
    case trebleCleffNotes = "Ноты в скрипичном ключе"
    case bassCleffNotes = "Ноты в басовом ключе"
    case durationsAndPauses = "Длительности и паузы"
}

class QuizArticle {
    var article: QuizArticles = .trebleCleffNotes
    var articleQuestions:[MusicTask]
    var result: ArticleResultsAndKeys

    var numberOfFinishedTasks: Int {
        get {
            return result.getDoneTasks()
        }
    }
    
    func updateCache() {
        let newNumberOfFinishedTasks = numberOfFinishedTasks + 1
        UserDefaults.standard.set(newNumberOfFinishedTasks,forKey:result.rawValue)
    }
    
    init(article: QuizArticles, questions: [MusicTask], result: ArticleResultsAndKeys) {
        self.article = article
        self.articleQuestions = questions
        self.result = result
    }
}




