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

    
    var numberOfFinishedTasks: Int {
        get {
           let num = articleQuestions.filter({$0.done == true}).count
            return num
        }
    }
    
    init(article: QuizArticles, questions: [MusicTask]) {
        self.article = article
        self.articleQuestions = questions
    }
}




