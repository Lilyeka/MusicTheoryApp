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
    let ICON_SIZE: CGFloat = 44.0
    
    // MARK: - Variables
    var presenter: MainViewOutputProtocol?
    var viewModels: [QuizArticleViewModel]?
    
    // MARK: - Views
    var collectionView: UICollectionView!

    var infoButton: UIButton = {
        var btn = UIButton(type: .infoDark)
        btn.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
        btn.tintColor = UIColor.darkGray
        return btn
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let configurator: MainConfiguratorProtocol = MainConfigurator()
        configurator.configure(with: self)
        self.presenter?.viewDidLoad()
        self.configureSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionViewCellsCircleAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Private methods
    private func collectionViewCellsCircleAnimation() {
        DispatchQueue.main.async {
            var i = 0
            while i < 3 {
                let indexPath = NSIndexPath(row: i, section: 0)
                if let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as? MainViewCollectionViewCell
                {
                    cell.animationFunc()
                }
                i += 1
            }
        }
    }
    
    private func configureSubviews() {
        guard let viewModels = viewModels, viewModels.count > 0  else {
            return
        }

        self.view.backgroundColor = .white
        
        let widthPercent: CGFloat = 0.8
        let heightPercent: CGFloat = 0.55
        
        let cellWidth = ((self.view.frame.size.width * widthPercent) - CGFloat((viewModels.count + 1))*self.COLLECTION_VIEW_SECTION_INSET)/CGFloat(viewModels.count)
        let cellHeight = (self.view.frame.size.height * heightPercent)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: COLLECTION_VIEW_SECTION_INSET,
            left: COLLECTION_VIEW_SECTION_INSET,
            bottom: COLLECTION_VIEW_SECTION_INSET,
            right: COLLECTION_VIEW_SECTION_INSET)
        layout.itemSize = CGSize(
            width: cellWidth,
            height: cellHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        self.collectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: MainViewCollectionViewCell.cellIdentifier)
        
        self.view.addSubview(self.collectionView)
        self.collectionView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.collectionView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: widthPercent).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: heightPercent, constant: 2*COLLECTION_VIEW_SECTION_INSET).isActive = true
        
        self.infoButton.addTarget(self, action: #selector(self.infoImageViewTapped), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: self.infoButton)
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
        self.collectionView.reloadData()
    }
    
    // MARK: - Public methods
    func showStartArticleAgainAlert(index: Int) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let attrMessage = NSAttributedString(
            string: "Пройти раздел заново?",
            attributes: [.font: UICollectionViewCell.QUESTION_FONT]
        )
        alert.setValue(attrMessage, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = self?.collectionView.cellForItem(at: indexPath) as? MainViewCollectionViewCell
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
    }
}


