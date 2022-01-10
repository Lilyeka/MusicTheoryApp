//
//  MainProtocols.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MainInteractorInputProtocol: AnyObject {
    var articles: [QuizArticleViewModel] { get }
    var currentArticle: QuizArticleViewModel? { get set }
    
    func getArticles()
    func prepareArticeToStartAgain(index: Int)
    func saveCurrentArticle()
    func articleDidSelect(index: Int)
}

protocol MainInteractorOutputProtocol: AnyObject {
    func articlesRecieved(_ items: [QuizArticleViewModel])
    func articlePreparedToStartAgain(article: QuizArticleViewModel)
    func currentArticleDidComplete(articleIndex: Int)
    func currentArticleDidNotComplete(articleModel: QuizArticle)
}

protocol MainViewInputProtocol: AnyObject {
    func updateView(with items: [QuizArticleViewModel])
}
 
protocol MainConfiguratorProtocol: AnyObject {
    func configure(with viewController: MainViewController)
}

protocol MainViewOutputProtocol: AnyObject {
    
    func viewDidLoad()
    func startArticleAgain(index: Int)
    func updateRecentSelectedArticle()
    func didSelectItemAt(index: Int)
}

protocol MainRouterProtocol: AnyObject {
    func showQuizScene(article: QuizArticle)
    func showStartAgainAlert(index: Int)
}
