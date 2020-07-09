//
//  MainPresenter.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainPresenter: MainPresenterProtocol/*, CurrencyPickerViewDelegate*/ {
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
   // weak var currencyPickerView: CurrencyPickerViewProtocol?
   // let inputCurrencyPickerViewTitle = "Choose input currency"
   // let outputCurrencyPickerViewTitle = "Choose output currency"
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView() {
//      view?.setInputValue(with: inputValue)
//      view?.setOutputValue(with: outputValue)
//      view?.setInputCurrencyShortName(with: inputCurrencyShortName)
//      view?.setOutputCurrencyShortName(with: outputCurrencyShortName)
//      view?.addDoneOnInputCurrencyKeyboard()
//      updateRateText()
      interactor.getAllCurrencies()
    }
    
    func showHUD() {
        view.showHUD()
    }
    
    func numberOfItemsInSection() -> Int {
        return interactor.arrayOfArticles.count
    }
    
    func titleForArticle(index: Int) -> String {
        return interactor.arrayOfArticles[index]
    }
    
    func didSelectItemAt(index: Int) {
        router.showQuizScene(articleNumber: index)
    }
}
