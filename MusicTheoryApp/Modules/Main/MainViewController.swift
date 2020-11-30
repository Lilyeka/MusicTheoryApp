//
//  MainViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    // MARK: - Constants
    let COLLECTION_VIEW_SECTION_INSET: CGFloat = 10.0
    
    // MARK: - Variables
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    // MARK: - Views
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: MainViewCollectionViewCell.cellIdentifier)
        return collectionView
    }()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        configureCollectionView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
   
    // MARK: - Private methods
    private func configureCollectionView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.articlesCollectionView)
        articlesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        articlesCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        articlesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        articlesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    @objc private func handleTap() {
        var indexPath = NSIndexPath(row: 0, section: 0)

        if let cell = articlesCollectionView.cellForItem(at: indexPath as IndexPath) as? MainViewCollectionViewCell {
            cell.animationFunc()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.cellIdentifier, for: indexPath) as! MainViewCollectionViewCell
        cell.textLabel.text = presenter.titleForArticle(index: indexPath.row)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}
