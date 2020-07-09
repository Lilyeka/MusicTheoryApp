//
//  MainViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    let COLLECTION_VIEW_SECTION_INSET: CGFloat = 10.0
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: COLLECTION_VIEW_SECTION_INSET, left: COLLECTION_VIEW_SECTION_INSET, bottom: COLLECTION_VIEW_SECTION_INSET, right: COLLECTION_VIEW_SECTION_INSET)
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    lazy var articlesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    
    // TODO: --
    // 1) Добавить тэйбл вью
    // 2) добавить массив со списком названий разделов
    //                  как в примере
    //https://medium.com/cr8resume/viper-architecture-for-ios-project-with-simple-demo-example-7a07321dbd29
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        articlesCollectionView.delegate = self
        articlesCollectionView.dataSource = self
        articlesCollectionView.backgroundColor = .white
        articlesCollectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
//        articlesCollectionView.register(GameHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GameHeaderCollectionReusableView")
//        articlesCollectionView.register(GameFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "GameFooterCollectionReusableView")
//        articlesCollectionView.register(GameWinnedFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "GameWinnedFooterCollectionReusableView")
        
        self.view.addSubview(self.articlesCollectionView)
        articlesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        articlesCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        articlesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        articlesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    func showHUD() {
//         DispatchQueue.main.async {
//             self.view.bringSubview(toFront: self.HUDView)
//             self.activityIndicatorView.alpha = 1
//             self.loadCurrenciesButton.alpha = 0
//             UIView.animate(withDuration: 0.5) {
//                 self.HUDView.alpha = 1
//             }
//         }
     }
}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MainViewCollectionViewCell
        cell.textLabel.text = presenter.titleForArticle(index: indexPath.row)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}
