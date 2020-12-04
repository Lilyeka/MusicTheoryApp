//
//  MainPresenter.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
        
    func numberOfItemsInSection() -> Int {
        //return interactor.arrayOfArticles.count
        return interactor.articles.count
    }
    
    func titleForArticle(index: Int) -> String {
        return interactor.articles[index].articleTitle()
    }
    
    func resultTitleForArticle(index: Int) -> String {
        return interactor.articles[index].resultTitle()
    }
    
    func imageForArticle(index: Int) -> UIImage? {
        guard let image = UIImage(named: interactor.articles[index].imageName) else {
            return nil
        }
        return image
    }
    
    func didSelectItemAt(index: Int) {
        let article = interactor.articles[index].model
        router.showQuizScene(article: article)
    }
}


