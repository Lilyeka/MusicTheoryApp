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
    let COLLECTION_VIEW_CELL_WIDTH: CGFloat = 180
    let COLLECTION_VIEW_CELL_HIGHT: CGFloat = 194
    let ICON_SIZE: CGFloat = 44.0
    
    // MARK: - Variables
    var presenter: MainPresenterProtocol!
  
    // MARK: - Views
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: COLLECTION_VIEW_SECTION_INSET, left: COLLECTION_VIEW_SECTION_INSET, bottom: COLLECTION_VIEW_SECTION_INSET, right: COLLECTION_VIEW_SECTION_INSET)
        layout.itemSize = CGSize(width: COLLECTION_VIEW_CELL_WIDTH, height: COLLECTION_VIEW_CELL_HIGHT)
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
    
    lazy var infoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "information")
        imageView.widthAnchor.constraint(equalToConstant: ICON_SIZE).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: ICON_SIZE).isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.infoImageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let configurator: MainConfiguratorProtocol = MainConfigurator()
        configurator.configure(with: self)
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       collectionViewCellsCircleAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func collectionViewCellsCircleAnimation() {
           DispatchQueue.main.async {
               var i = 0
               while i < 3 {
                   let indexPath = NSIndexPath(row: i, section: 0)
                   if let cell = self.articlesCollectionView.cellForItem(at: indexPath as IndexPath) as? MainViewCollectionViewCell
                   {
                        cell.animationFunc()
                   }
                   i += 1
               }
           }
    }
   
    // MARK: - Private methods
    private func configureCollectionView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.articlesCollectionView)
        articlesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        articlesCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        articlesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        articlesCollectionView.heightAnchor.constraint(equalToConstant: COLLECTION_VIEW_CELL_HIGHT + 2*COLLECTION_VIEW_SECTION_INSET).isActive = true
        
        self.view.addSubview(infoImageView)
        infoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        infoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
    }
    
    func showStartArticleAgainAlert(index: Int) {
        let alert = UIAlertController(title: "", message: "Пройти раздел заново?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action) in
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = self.articlesCollectionView.cellForItem(at: indexPath as IndexPath) as? MainViewCollectionViewCell
            { cell.clearModel() }
            presenter.startArticleAgain(index: index)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func infoImageViewTapped() {
        let aboutVC = GameInfoViewController()
        aboutVC.modalPresentationStyle = .overCurrentContext
        aboutVC.modalTransitionStyle = .crossDissolve
        self.present(aboutVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.cellIdentifier, for: indexPath) as! MainViewCollectionViewCell
        cell.configureSubviews(viewModel: presenter.interactor.articles[indexPath.row], frame: CGRect.zero)
        cell.setNeedsDisplay()
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}

// MARK: -QuizViewControllerDelegate
extension MainViewController: QuizViewControllerDelegate {
    func storeRightAnswer() {
        presenter.updateRecentSelectedArticle()
    }
}
