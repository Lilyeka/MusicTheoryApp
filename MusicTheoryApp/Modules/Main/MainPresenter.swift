//
//  MainPresenter.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainPresenter: MainViewOutputProtocol, MainInteractorOutputProtocol {
    weak var view: MainViewInputProtocol?
    var interactor: MainInteractorInputProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewInputProtocol) {
        self.view = view
    }
    
    //MARK: - MainViewOutputProtocol
    func viewDidLoad() {
        self.interactor?.getArticles()
    }
    
    func didSelectItemAt(index: Int) {
        self.interactor.articleDidSelect(index: index)
    }
        
    func updateRecentSelectedArticle() {
        self.interactor.saveCurrentArticle()
    }
    
    func startArticleAgain(index: Int) {
        self.interactor.prepareArticeToStartAgain(index: index)
    }
    
    //MARK: - MainInteractorOutputProtocol
    func articlesRecieved(_ items: [QuizArticleViewModel]) {
        self.view?.updateView(with: items)
    }
    
    func articlePreparedToStartAgain(article: QuizArticleViewModel) {
        self.router.showQuizScene(article: article.model)
    }
    
    func currentArticleDidComplete(articleIndex: Int) {
        self.router.showStartAgainAlert(index: articleIndex)
    }
    
    func currentArticleDidNotComplete(articleModel: QuizArticle) {
        self.router.showQuizScene(article: articleModel)
    }
}
