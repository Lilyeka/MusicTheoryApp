//
//  MainInteractor.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol!
    var currentArticle: QuizArticleViewModel?
    
    var articles: [QuizArticleViewModel] = [
        QuizArticleViewModel(
            model: QuizArticle(article: .trebleCleffNotes, questions: MusicTasks.shared.tasks, result: .firstArticleDoneTasksNumber),
            imageName: "mainTreble"),
        QuizArticleViewModel(
            model: QuizArticle(article: .bassCleffNotes, questions:MusicTasksBass.shared.tasks, result: .secondArticleDoneTasksNumber),
            imageName: "mainBass"),
        QuizArticleViewModel(
            model: QuizArticle(article: .durationsAndPauses, questions: MusicTasksPausesDurations.shared.tasks, result: .thirdArticleDoneTasksNumber),
            imageName: "mainDuration")
    ]
    
    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getArticles() {
        self.presenter.articlesRecieved(articles)
    }
    
    func prepareArticeToStartAgain(index: Int) {
        let article = self.articles[index]
        self.currentArticle = article
        article.previousPercent = article.percent
        article.clearArticleResult()
        self.presenter.articlePreparedToStartAgain(article: article)
    }
    
    func saveCurrentArticle() {
        self.currentArticle?.model.updateCache()
    }
    
    func articleDidSelect(index: Int) {
        let article = self.articles[index]
        self.currentArticle = article
        article.previousPercent = article.percent
        
        if article.percent == 100 {
            self.presenter.currentArticleDidComplete(articleIndex: index)
        } else {
            self.presenter.currentArticleDidNotComplete(articleModel: article.model)
        }
    }
}
