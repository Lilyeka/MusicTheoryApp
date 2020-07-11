//
//  QuizViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 09.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, QuizViewProtocol {
    var presenter: QuizPresenterProtocol!
    var configurator: QuizConfiguratorProtocol = QuizConfigurator()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        return layout
    }()
    
    lazy var quizCollectionView: UICollectionView! = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(QuizCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    var questions = MusicTasks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        configurator.configure(with: self)
        configureCollectionView()
    }
    
    func configureCollectionView() {
        self.view.addSubview(self.quizCollectionView)
        quizCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        quizCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        quizCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        quizCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    override func viewDidLayoutSubviews() {
        layout.itemSize = CGSize(width:quizCollectionView.frame.width , height: quizCollectionView.frame.height)
    }
}

extension QuizViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questions.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizCollectionViewCell
        
        if questions.tasks[indexPath.row] is MusicTaskSelectNote {
            var viewModel = MusicTaskSelectNoteViewModel(model: questions.tasks[indexPath.row] as! MusicTaskSelectNote)
            var frameForTaskView = quizCollectionView.frame
            var musicTaskSelectNoteView = MusicTaskSelectNoteView (
                viewModel: viewModel,
                frame: frameForTaskView
            )
            cell.config(withView:musicTaskSelectNoteView)
           // cell.backgroundView = MusicTaskSelectNoteView(viewModel: viewModel, frame:frameForTaskView)
        }
       // cell.backgroundView =
        return cell
    }
    
    
    
    
}
