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
    let COLLECTION_VIEW_CELL_HIGHT: CGFloat = 222
    
    // MARK: - Variables
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
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
    

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        configureCollectionView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//         UIGraphicsBeginImageContext(self.view.frame.size)
//               UIImage(named: "bgImage")?.draw(in: self.view.bounds)
//
//               if let image = UIGraphicsGetImageFromCurrentImageContext(){
//                   UIGraphicsEndImageContext()
//                   self.view.backgroundColor = UIColor(patternImage: image)
//               }else{
//                   UIGraphicsEndImageContext()
//                   debugPrint("Image not available")
//                }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        articlesCollectionView.reloadData()
        DispatchQueue.main.async {
            var i = 0
            while i < 3 {
                let indexPath = NSIndexPath(row: i, section: 0)
                if let cell = self.articlesCollectionView.cellForItem(at: indexPath as IndexPath) as? MainViewCollectionViewCell,
                   self.presenter.articleResultDidChande(index: i)
                {
                    cell.animationFunc { [i]  in
                        self.presenter.afterAnimation(index: i)
                        print("Сработала круговая анимация для ячейки \(i)")
                    }
                    
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
    }
    
//    @objc private func handleTap() {
//        let indexPath = NSIndexPath(row: 0, section: 0)
//        if let cell = articlesCollectionView.cellForItem(at: indexPath as IndexPath) as? MainViewCollectionViewCell {
//            cell.animationFunc()
//        }
//    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.cellIdentifier, for: indexPath) as! MainViewCollectionViewCell
    
        if let image = presenter.imageForArticle(index: indexPath.row) {
            cell.imageView.image = image
        }
        cell.resultLabel.text = presenter.resultTitleForArticle(index: indexPath.row)
        cell.textLabel.text = presenter.titleForArticle(index: indexPath.row)
        cell.endAngle = presenter.resultAngle(index: indexPath.row)
        cell.previousEndAngle = presenter.previousResultAngle(index: indexPath.row)
        cell.setNeedsDisplay()
        cell.startButton.tag = indexPath.row
        cell.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        cell.startButton.isHidden = !presenter.showStartButton(index: indexPath.row)
        return cell
    }
    
    @objc func startButtonTapped(sender: UIButton) {
        let index = sender.tag
        presenter.startArticleAgain(index: index)
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

