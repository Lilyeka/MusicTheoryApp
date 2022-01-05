//
//  QuizViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 09.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol QuizViewControllerDelegate: NSObjectProtocol {
    func storeRightAnswer()
}

class QuizViewController: UIViewController, QuizViewProtocol {
    //MARK: -Delegates
    weak var delegate: QuizViewControllerDelegate?
    
    //MARK: -ViewControllers
    private let fireworkController = ClassicFireworkController()
    
    //MARK: -Variables
    var presenter: QuizPresenterProtocol!
    var configurator: QuizConfiguratorProtocol = QuizConfigurator()
    var currentQuestionNumber: Int = 0
    var numberOfFinishedTasks: Int!
    var questions: [MusicTask]!
    var notFinishedQuestions:[MusicTask] {
        get {
            var questionsCopy = questions
            questionsCopy?.removeFirst(numberOfFinishedTasks!)
            return questionsCopy!
        }
    }
    
    //MARK: -Views
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
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(QuizSelectNoteCollectionViewCell.self, forCellWithReuseIdentifier: QuizSelectNoteCollectionViewCell.cellIdentifier)
        collectionView.register(QuizShowNoteCollectionViewCell.self, forCellWithReuseIdentifier: QuizShowNoteCollectionViewCell.cellIdentifier)
        collectionView.register(QuizWriteNoteCollectionViewCell.self, forCellWithReuseIdentifier: QuizWriteNoteCollectionViewCell.cellIdentifier)
        collectionView.register(QuizSelectNoteInWordCollectionViewCell.self, forCellWithReuseIdentifier: QuizSelectNoteInWordCollectionViewCell.cellIdentifier)
        collectionView.register(QuizPauseAndDurationCollectionViewCell.self, forCellWithReuseIdentifier: QuizPauseAndDurationCollectionViewCell.cellIdentifier)
        collectionView.register(QuizAdditionCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    lazy var lastQuestionRightAnswerAlert: UIAlertController! = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let attrTitle = NSAttributedString(
            string: "Вы прошли весь раздел, поздравляем!",
            attributes: [.font: UICollectionViewCell.QUESTION_FONT]
        )
        alert.setValue(attrTitle, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.okActionForLastAlert()}))
        return alert
    }()
    
    lazy var rightAnswerAlert: UIAlertController! = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        

        
        let attrTitle = NSAttributedString(
            string: "Верный ответ!",
            attributes: [.font: UICollectionViewCell.QUESTION_FONT]
        )
//        let attrMessage = NSAttributedString(
//            string: "Поехали дальше!",
//            attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]
//        )
        
        alert.setValue(attrTitle, forKey: "attributedTitle")
      // alert.setValue(attrMessage, forKey: "attributedMessage")
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.okAction()})
        )
        return alert
    }()
    
    lazy var wrongAnswerAlert: UIAlertController! = {
        let alert = UIAlertController(title: "Неверный ответ", message: "Попробуй еще раз!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configurator.configure(with: self)
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        layout.itemSize = CGSize(width:quizCollectionView.frame.width , height: quizCollectionView.frame.height)
    }
    
    //MARK: -Private methods
    fileprivate func configureCollectionView() {
        self.view.addSubview(self.quizCollectionView)
        quizCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        quizCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        quizCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        quizCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    fileprivate func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.quizCollectionView.center, to: self.quizCollectionView)
        let index = quizCollectionView!.indexPathForItem(at: center)
        print(index ?? "index not found")
        return index
    }
    
    func okAction() {
        let collectionBounds = quizCollectionView.bounds
        var contentOffset: CGFloat = 0
        contentOffset = CGFloat(floor(self.quizCollectionView.contentOffset.x + collectionBounds.size.width))
        currentQuestionNumber += currentQuestionNumber >= notFinishedQuestions.count ? 0 : 1
        //было тут
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func okActionForLastAlert() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func moveToFrame(contentOffset: CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset, y : self.quizCollectionView.contentOffset.y, width : self.quizCollectionView.frame.width, height: self.quizCollectionView.frame.height)
        self.quizCollectionView.scrollRectToVisible(frame, animated: true)
    }
}

//MARK: -UICollectionViewDataSource
extension QuizViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notFinishedQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let frame = quizCollectionView.frame
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let question = notFinishedQuestions[indexPath.row]
        switch question {
        case is MusicTaskSelectNote:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizSelectNoteCollectionViewCell.cellIdentifier, for: indexPath) as? QuizSelectNoteCollectionViewCell
            if cell == nil {
                cell = QuizSelectNoteCollectionViewCell(frame: frame)
            }
            let viewModel = MusicTaskSelectNoteViewModel(model: question as! MusicTaskSelectNote)
            cell?.configureSubviews(viewModel: viewModel, frame: frame)
            cell?.delegate = self
            return cell!
        case is MusicTaskShowNoteOnThePiano:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizShowNoteCollectionViewCell.cellIdentifier, for: indexPath) as? QuizShowNoteCollectionViewCell
            if cell == nil {
                cell = QuizShowNoteCollectionViewCell(frame: frame)
            }
            let viewModel = MusicTaskShowtNoteOnThePianoViewModel(model: question as! MusicTaskShowNoteOnThePiano)
            cell?.configureSubViews(viewModel: viewModel, frame: frame)
            cell?.pianoView.delegate = self
            return cell!
        case is MusicTaskSelectNoteInWord:
            let q = question as! MusicTaskSelectNoteInWord
            if q.needToTypeAnswer! {
                let viewModel = MusicTaskWriteNoteInWordViewModel(model: q)
                var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizWriteNoteCollectionViewCell.cellIdentifier, for: indexPath) as? QuizWriteNoteCollectionViewCell
                if cell == nil {
                    cell = QuizWriteNoteCollectionViewCell(frame: frame, viewModel: viewModel)
                }
                cell?.configureSubviews(viewModel: viewModel, frame: frame)
                cell?.delegate = self
                return cell!
            } else {
                let viewModel = MusicTaskSelectNoteInWordViewModel(model: q)
                var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizSelectNoteInWordCollectionViewCell.cellIdentifier, for: indexPath) as? QuizSelectNoteInWordCollectionViewCell
                if cell == nil {
                    cell = QuizSelectNoteInWordCollectionViewCell(frame: frame)
                }
                cell?.configureSubviews(viewModel: viewModel, frame: frame)
                cell?.delegate = self
                return cell!
            }
        case is MusicTaskPauseAndDuration:
            let viewModel = MusicTaskPauseAndDurationViewModel(model: question as! MusicTaskPauseAndDuration)
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizPauseAndDurationCollectionViewCell.cellIdentifier, for: indexPath) as? QuizPauseAndDurationCollectionViewCell
            if cell == nil { cell = QuizPauseAndDurationCollectionViewCell(frame: frame)}
            cell!.configureSubviews(viewModel: viewModel, frame: frame)
            cell!.delegate = self
            return cell!
        case is MusicTaskAddition:
            let viewModel = MusicTaskAdditionViewModel(model: question as! MusicTaskAddition)
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionCollectionViewCell
            if cell == nil {
                cell = QuizAdditionCollectionViewCell(frame: frame)
            }
            cell!.configureSubviews(viewModel: viewModel, frame: frame)
            cell?.delegate = self
            return cell!
        default:
            return cell
        }
    }
}

//MARK: -QuizSelectAnswerDelegate
extension QuizViewController: QuizSelectAnswerDelegate {
    func additionalRightAnswerReaction(view: UIView) {
        self.fireworkController.addFireworks(count: 2, sparks: 8, around: view)
        view.isUserInteractionEnabled = false
    }
    
    func rightAnswerReaction() {
        if rightAnswerAlert.isBeingPresented {
            rightAnswerAlert.dismiss(animated: true, completion: nil)
        }
        presentRightAnswerAlerts()
    }
    
    func wrongAnswerReaction() {
        if wrongAnswerAlert.isBeingPresented {
            wrongAnswerAlert.dismiss(animated: true, completion: nil)
        }
        self.present(wrongAnswerAlert, animated: true, completion: nil)
    }
    
    fileprivate func presentRightAnswerAlerts() {
        // update cache
        delegate?.storeRightAnswer()
        if (currentQuestionNumber == notFinishedQuestions.count - 1) {
            self.present(lastQuestionRightAnswerAlert, animated: true, completion: nil)
        } else {
            self.present(rightAnswerAlert, animated: true, completion: nil)
        }
    }
}

//MARK: -PianoViewDelegate
extension QuizViewController: PianoViewDelegate {
    func keyTapped(withNotes: [(Note.NoteName, Note.Tonality)], view: UIView) {
        let model = notFinishedQuestions[currentQuestionNumber] as? MusicTaskShowNoteOnThePiano
        if let model = model {
            let viewModel = MusicTaskShowtNoteOnThePianoViewModel(model: model)
            if viewModel.checkUserAnswer(userAnswer: withNotes) {
                self.fireworkController.addFireworks(count: 2, sparks: 8, around: view)
                view.backgroundColor = UIColor(named: "doneArticleColour")
                view.isUserInteractionEnabled = false
                if (withNotes.count) > 0 {
                    let note = withNotes[0]
                    let noteNameLabel = UILabel(
                        frame:
                            CGRect(x: view.bounds.minX + 5,
                                   y: view.bounds.maxY - 40.0,
                                   width: view.bounds.size.width - 10.0,
                                   height: 40.0)
                    )
                    noteNameLabel.adjustsFontSizeToFitWidth = true
                    noteNameLabel.text = note.0.noteRusName()
                    noteNameLabel.textAlignment = .center
                    noteNameLabel.textColor = .white
                    view.addSubview(noteNameLabel)
                }
                presentRightAnswerAlerts()
            }
        }
    }
}
