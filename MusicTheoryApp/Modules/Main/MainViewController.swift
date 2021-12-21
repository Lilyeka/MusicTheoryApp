//
//  MainViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Constants
    let COLLECTION_VIEW_SECTION_INSET: CGFloat = 10.0
    let COLLECTION_VIEW_CELL_WIDTH: CGFloat = 180
    let COLLECTION_VIEW_CELL_HIGHT: CGFloat = 194
    let ICON_SIZE: CGFloat = 44.0
    
    // MARK: - Variables
    var presenter: MainViewOutputProtocol?
    var viewModels: [QuizArticleViewModel]?
      
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
     
        self.configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       collectionViewCellsCircleAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewDidLoad()
        //navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private methods
    private func collectionViewCellsCircleAnimation() {
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
    
    private func configureCollectionView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.articlesCollectionView)
        self.articlesCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.articlesCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.articlesCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.90).isActive = true
        self.articlesCollectionView.heightAnchor.constraint(equalToConstant: COLLECTION_VIEW_CELL_HIGHT + 2*COLLECTION_VIEW_SECTION_INSET).isActive = true
        
        self.view.addSubview(self.infoImageView)
        self.infoImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        self.infoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Public methods
    func showStartArticleAgainAlert(index: Int) {
        let alert = UIAlertController(title: "", message: "Пройти раздел заново?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = self?.articlesCollectionView.cellForItem(at: indexPath) as? MainViewCollectionViewCell
            { cell.clearModel() }
            self?.presenter?.startArticleAgain(index: index)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
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
        return self.viewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.cellIdentifier, for: indexPath) as? MainViewCollectionViewCell,
            let viewModel = self.viewModels?[indexPath.row]
            else { return UICollectionViewCell() }
        cell.configureSubviews(viewModel: viewModel, frame: CGRect.zero)
        cell.setNeedsDisplay()
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemAt(index: indexPath.row)
    }
}

// MARK: -QuizViewControllerDelegate
extension MainViewController: QuizViewControllerDelegate {
    func storeRightAnswer() {
        self.presenter?.updateRecentSelectedArticle()
    }
}
// MARK: -MainViewInputProtocol
extension MainViewController: MainViewInputProtocol {
    func updateView(with items: [QuizArticleViewModel]) {
        self.viewModels = items
        self.articlesCollectionView.reloadData()
    }
}


