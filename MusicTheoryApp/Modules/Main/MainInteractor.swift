//
//  MainInteractor.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol!
    
    var articles: [QuizArticleViewModel] = [
        QuizArticleViewModel(model: QuizArticle(article: .trebleCleffNotes, percent: 0), imageName: "mainTreble"),
        QuizArticleViewModel(model: QuizArticle(article: .bassCleffNotes, percent: 0), imageName: "mainBass"),
        QuizArticleViewModel(model: QuizArticle(article: .durationsAndPauses, percent: 0), imageName: "mainDuration")
    ]

    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
}
