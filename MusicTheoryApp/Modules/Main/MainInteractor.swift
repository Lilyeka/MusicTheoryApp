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
            return ["Ноты в скрипичном ключе", "Ноты в басовом ключе", "И т.д."]
        }
    }
    
    //let currencyService: CurrencyServiceProtocol = CurrencyService()
    // let serverService: ServerServiceProtocol = ServerService()
    
    //var currencyChangingMode: CurrencyChangingMode?
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getAllCurrencies() {
        presenter.showHUD()
//        serverService.getAllCurrencies { (dict, error) in
//            
//            if let error = error {
//                self.presenter.hideHUD()
//                self.presenter.showLoadCurrenciesButton()
//                self.presenter.showAlertView(with: error.localizedDescription)
//                return
//            }
//            
//            if let dictResponse = dict {
//                self.currencyService.saveAllCurrencies(with: dictResponse, completion: { (error) in
//                    
//                    if let error = error {
//                        self.presenter.hideHUD()
//                        self.presenter.showAlertView(with: error.localizedDesc)
//                        return
//                    }
//                    self.currencyService.sortAndUpdateCurrentCurrencies()
//                    self.getOutputCurrencyRatio(newCurrency: nil)
//                })
//            }
//        }
    }
}
