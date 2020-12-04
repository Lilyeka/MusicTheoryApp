//
//  QuizArticleViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.12.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

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
        return "Выполнено на \(String(describing: model.percent))%"
    }
    
}
