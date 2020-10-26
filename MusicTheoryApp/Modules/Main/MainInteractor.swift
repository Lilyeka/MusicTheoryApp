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
    var arrayOfArticles: [String] {
        get {// TODO: need return from service!
            return ["Ноты в скрипичном ключе", "Ноты в басовом ключе", "Длительности и паузы"]
        }
    }
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getAllCurrencies() {
        presenter.showHUD()
    }
}
