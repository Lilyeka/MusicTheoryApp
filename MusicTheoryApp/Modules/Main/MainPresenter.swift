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
    
    func resultAngle(index: Int) -> CGFloat {
        return interactor.articles[index].percentInAngle
    }
    
    func previousResultAngle(index: Int) -> CGFloat {
        return interactor.articles[index].previousPercentInAngle
       }
    
    func articleResultDidChande(index: Int) -> Bool {
        return interactor.articles[index].percentIsChanged
    }
    
    func imageForArticle(index: Int) -> UIImage? {
        guard let image = UIImage(named: interactor.articles[index].imageName) else {
            return nil
        }
        return image
    }
    
    func didSelectItemAt(index: Int) {
        let article = interactor.articles[index]//.model
        interactor.currentArticle = article
        article.previousPercent = article.percent
        router.showQuizScene(article: article.model)
    }
    
    func afterAnimation(index: Int) {
        interactor.articles[index].previousPercent = interactor.articles[index].percent
    }
    
    func updateRecentSelectedArticle() {
        interactor.currentArticle?.model.updateCache()
    }
}


