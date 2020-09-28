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
    var currentQuestionNumber: Int = 0
    
    private let fireworkController = ClassicFireworkController()
    
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
        collectionView.register(QuizCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(QuizSelectNoteCollectionViewCell.self, forCellWithReuseIdentifier: QuizSelectNoteCollectionViewCell.cellIdentifier)
        collectionView.register(QuizShowNoteCollectionViewCell.self, forCellWithReuseIdentifier: QuizShowNoteCollectionViewCell.cellIdentifier)
        collectionView.register(QuizWriteNoteCollectionViewCell.self, forCellWithReuseIdentifier: QuizWriteNoteCollectionViewCell.cellIdentifier)
        collectionView.register(QuizSelectNoteInWordCollectionViewCell.self, forCellWithReuseIdentifier: QuizSelectNoteInWordCollectionViewCell.cellIdentifier)
        collectionView.register(QuizPauseAndDurationCollectionViewCell.self, forCellWithReuseIdentifier: QuizPauseAndDurationCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    var questions = MusicTasksPauses()/*MusicTasks()*//* MusicTasksBass()*/
    
    //Mark: -LifeCycle
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
}

extension QuizViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questions.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     //   currentQuestionNumber = indexPath.row
        print("currentQuestionNumber = " + String(currentQuestionNumber) + " from cellForItemAt")
        let frame = quizCollectionView.frame
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizCollectionViewCell
        
        let question = questions.tasks[indexPath.row]
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
            cell?.delegate = self
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
                let viewModel = MusicTaskSelectNoteInWordViewModel(model:questions.tasks[indexPath.row] as! MusicTaskSelectNoteInWord)
                var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizSelectNoteInWordCollectionViewCell.cellIdentifier, for: indexPath) as? QuizSelectNoteInWordCollectionViewCell
                if cell == nil {
                    cell = QuizSelectNoteInWordCollectionViewCell(frame: frame)
                }
                cell?.configureSubviews(viewModel: viewModel, frame: frame)
                cell?.delegate = self
                return cell!
            }
        case is MusicTaskPauseAndDuration:
            let viewModel = MusicTaskPauseAndDurationViewModel(model: questions.tasks[indexPath.row] as! MusicTaskPauseAndDuration)
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizPauseAndDurationCollectionViewCell.cellIdentifier, for: indexPath) as? QuizPauseAndDurationCollectionViewCell
            if cell == nil { cell = QuizPauseAndDurationCollectionViewCell(frame: frame)}
            cell!.configureSubviews(viewModel: viewModel, frame: frame)
            cell?.delegate = self
            return cell!
        default:
            return cell
        }
    }
    
}

extension QuizViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let frame = quizCollectionView.frame
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizCollectionViewCell
        let question = questions.tasks[indexPath.row]
        
        switch question {
        case is MusicTaskSelectNote:
            break
        case is MusicTaskShowNoteOnThePiano:
            break
        case is MusicTaskSelectNoteInWord:
            let q = question as! MusicTaskSelectNoteInWord
            if q.needToTypeAnswer! {
                var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizWriteNoteCollectionViewCell.cellIdentifier, for: indexPath) as? QuizWriteNoteCollectionViewCell
                if cell == nil {
                    cell = QuizWriteNoteCollectionViewCell(frame: frame)
                }
                cell!.endEditing(true)
            } else {
                
            }
            
        default:
            break
        }
    }
}


extension QuizViewController: QuizSelectNoteCollectionViewCellDelegate, QuizSelectNoteInWordCollectionViewCellDelegate {

    func rightNoteTappedReaction(noteView: UIView) {
        fireworkController.addFireworks(count: 2, sparks: 8, around: noteView)
        noteView.isUserInteractionEnabled = false
    }
}

extension QuizViewController: QuizShowNoteCollectionViewCellDelegate, QuizWriteNoteCollectionViewCellDelegate, QuizPauseAndDurationCollectionViewCellDelegate {
    
    func additionalRightAnswerReaction(view: UIView) {
        fireworkController.addFireworks(count: 2, sparks: 8, around: view)
        view.isUserInteractionEnabled = false
    }
    
    func rightAnswerReaction() {
        let alert = UIAlertController(title: "Верный ответ", message: "Поехали дальше!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.okAction()}))
        self.present(alert, animated: true)
    }
    
    func wrongAnswerReaction() {
        let alert = UIAlertController(title: "Неверный ответ", message: "Попробуй еще раз!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func okAction() {
        let collectionBounds = quizCollectionView.bounds
        var contentOffset: CGFloat = 0
        contentOffset = CGFloat(floor(self.quizCollectionView.contentOffset.x + collectionBounds.size.width))
        currentQuestionNumber += currentQuestionNumber >= questions.tasks.count ? 0 : 1
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset, y : self.quizCollectionView.contentOffset.y, width : self.quizCollectionView.frame.width, height: self.quizCollectionView.frame.height)
        self.quizCollectionView.scrollRectToVisible(frame, animated: true)
    }
}

extension QuizViewController: PianoViewDelegate {
    func keyTapped(withNotes: [(Note.NoteName, Note.Tonality)], view: UIView) {
        
        let model = questions.tasks[currentQuestionNumber] as? MusicTaskShowNoteOnThePiano
        if let model = model {
            let viewModel = MusicTaskShowtNoteOnThePianoViewModel(model: model)
        if viewModel.checkUserAnswer(userAnswer: withNotes) {
            fireworkController.addFireworks(count: 2, sparks: 8, around: view)
            view.backgroundColor = .green
            view.isUserInteractionEnabled = false
            if (withNotes.count) > 0 {
                let note = withNotes[0]
            if note != nil { // добавляем название ноты на клавишу
                let noteLabelHeight:CGFloat = 40.0
                var noteNameLabel = UILabel(frame:CGRect(x: view.bounds.minX + 5, y: view.bounds.maxY - noteLabelHeight, width: view.bounds.size.width - 10.0, height: noteLabelHeight))
                noteNameLabel.font = QuizShowNoteCollectionViewCell.QUESTION_FONT
                noteNameLabel.text = note.0.noteRusName()
                noteNameLabel.textAlignment = .center
                view.addSubview(noteNameLabel)
            }
            }
       
            let alert = UIAlertController(title: "Верный ответ", message: "Поехали дальше!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.okAction()}))
            self.present(alert, animated: true)
        }
        }
        
    }
}









