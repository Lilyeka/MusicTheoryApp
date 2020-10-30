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
        return interactor.arrayOfArticles.count
    }
    
    func titleForArticle(index: Int) -> String {
        return interactor.arrayOfArticles[index].rawValue
    }
    
    func didSelectItemAt(index: Int) {
        let article = interactor.arrayOfArticles[index]
        router.showQuizScene(article: article)
    }
}


