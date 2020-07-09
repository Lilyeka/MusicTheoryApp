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
//    func setInputValue(with value: String?)
//     func setOutputValue(with value: String?)
//     func setInputCurrencyShortName(with shortName: String)
//     func setOutputCurrencyShortName(with shortName: String)
//     func addDoneOnInputCurrencyKeyboard()
       func showHUD()
//     func showLoadCurrenciesButton()
//     func hideHUD()
//     func showAlertView(with text: String)
//     func showPickerView()
//     func hidePickerView()
//     func hideKeyboard()
//     func setRateText(with rateText: String)
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
//    var rateText: String { get }
    func configureView()
    func numberOfItemsInSection() -> Int
    func titleForArticle(index: Int) -> String
    func didSelectItemAt(index: Int)
//    func textFieldDidBeginEditing()
//    func inputValueChanged(to newInputValue: String)
//    func inputValueCleared()
//    func inputCurrencyButtonClicked()
//    func outputCurrencyButtonClicked()
//    func loadCurrenciesButtonClicked()
//    func infoButtonClicked()
      func showHUD()
//    func showLoadCurrenciesButton()
//     func hideHUD()
//    func updateOutputValue()
//    func showAlertView(with text: String)
//    func inputCurrencyNameUpdated()
//    func outputCurrencyNameUpdated()
//    func updateRateText()
}


protocol MainInteractorProtocol: class {
    var arrayOfArticles: [String] { get }
//    var inputValue: Double { set get }
//    var outputValue: Double { get }
//    var inputCurrencyShortName: String { get }
//    var outputCurrencyShortName: String { get }
//    var inputCurrencyIndex: Int { get }
//    var outputCurrencyIndex: Int { get }
//    var outputCurrencyRatio: Double { get }
    func getAllCurrencies()
//    func getCurrencyNames() -> [String]
//    func inputCurrencyChanging()
//    func outputCurrencyChanging()
//    func currencyChanged(selectedIndex: Int)
}

protocol MainRouterProtocol: class {
    func showQuizScene(articleNumber: Int)
   // func showAboutScene()
   // func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

