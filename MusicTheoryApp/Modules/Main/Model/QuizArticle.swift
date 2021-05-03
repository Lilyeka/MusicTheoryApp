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
            var doneTasks = result.doneTasks
            if doneTasks == 0 {
                let num = articleQuestions.filter({$0.done == true}).count
                UserDefaults.standard.set(num,forKey:result.rawValue)
                doneTasks = result.doneTasks
            }
            return doneTasks
        }
    }
    
    init(article: QuizArticles, questions: [MusicTask], result: ArticleResultsAndKeys) {
        self.article = article
        self.articleQuestions = questions
        self.result = result
    }
}




