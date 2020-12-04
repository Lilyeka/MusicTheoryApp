//
//  MainProtocols.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: MainViewController)
}

protocol MainViewProtocol: class {
    var presenter: MainPresenterProtocol! {get set}
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    var interactor: MainInteractorProtocol! {set get}

    func numberOfItemsInSection() -> Int
    func titleForArticle(index: Int) -> String
    func resultTitleForArticle(index: Int) -> String
    func imageForArticle(index: Int) -> UIImage?
    func didSelectItemAt(index: Int)
}

protocol MainInteractorProtocol: class {
    var articles: [QuizArticleViewModel] { get }
}

protocol MainRouterProtocol: class {
    func showQuizScene(article: QuizArticle)
}

