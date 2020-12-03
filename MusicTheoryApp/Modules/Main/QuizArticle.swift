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
    var percent: Int!
    
    init(article: QuizArticles, percent: Int) {
        self.article = article
        self.percent = percent
    }
}

class QuizArticleViewModel {
    var model: QuizArticle
    var imageName: String
    
    init(model: QuizArticle, imageName: String) {
        self.model = model
        self.imageName = imageName
    }
    
    func articleTitle() -> String {
        return model.article.rawValue
    }
    
    func resultTitle() -> String {
        return "Выполнено на \(String(describing: model.percent!))%"
    }
    
}


