//
//  ViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 29.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 16.0)
    
    let TOP_OFFSET: CGFloat = 15.0
    let BOTTOM_OFFSET: CGFloat = 15.0
    let LEFT_OFFSET: CGFloat = 15.0
    let RIGHT_OFFSET: CGFloat = 15.0
    let LABEL_HEIGHT: CGFloat = 45.0
   
    var tasksStorage: MusicTasks!
    
    var musicTaskSelectNoteView: MusicTaskSelectNoteView!
    var musicTaskShowNoteView: MusicTaskShowNoteOnThePianoView!
    var musicTaskSelectNoteInWordView: MusicTaskSelectNoteInWordView!
    
    override func viewDidAppear(_ animated: Bool) {
        let safeAreaLayoutFrame = view.safeAreaLayoutGuide.layoutFrame
        let safeAreaWidth = safeAreaLayoutFrame.width
        let safeAreaHeight = safeAreaLayoutFrame.height
        let taskViewFrame = CGRect(x: Int(safeAreaLayoutFrame.minX) + Int(TOP_OFFSET),
          y: Int(safeAreaLayoutFrame.minY) + Int(LEFT_OFFSET),
          width: Int(safeAreaWidth) - Int(LEFT_OFFSET) - Int(RIGHT_OFFSET),
          height: Int(safeAreaHeight) - Int(TOP_OFFSET) - Int(BOTTOM_OFFSET)
        )
  //---------------------------------------------------------------
        let task0: MusicTaskSelectNote = tasksStorage.tasks[0] as! MusicTaskSelectNote
        let task0ViewModel =  MusicTaskSelectNoteViewModel(model: task0)
        musicTaskSelectNoteView = MusicTaskSelectNoteView(
            viewModel: task0ViewModel,
            frame: taskViewFrame
        )
        musicTaskSelectNoteView.delegate = self
//        self.view.addSubview(musicTaskSelectNoteView)
  //---------------------------------------------------------------
        let task8: MusicTaskShowNoteOnThePiano = tasksStorage.tasks[8] as! MusicTaskShowNoteOnThePiano
        let task8ViewModel = MusicTaskShowtNoteOnThePianoViewModel(model: task8)
        musicTaskShowNoteView = MusicTaskShowNoteOnThePianoView(
            viewModel: task8ViewModel,
            frame: taskViewFrame
        )
        musicTaskShowNoteView.pianoView.delegate = self
    //    self.view.addSubview(musicTaskShowNoteView)
        
  //---------------------------------------------------------------
        let task9: MusicTaskSelectNoteInWord = tasksStorage.tasks[9] as! MusicTaskSelectNoteInWord
        let task9ViewModel = MusicTaskSelectNoteInWordViewModel(model: task9)
        musicTaskSelectNoteInWordView = MusicTaskSelectNoteInWordView(
            viewModel: task9ViewModel,
            frame: taskViewFrame
        )
        musicTaskSelectNoteInWordView.delegate = self
        self.view.addSubview(musicTaskSelectNoteInWordView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tasksStorage = MusicTasks()
    }
        
    fileprivate func convertNotesToViewModels(notes:[Note]) -> [NoteViewModel] {
        var resultArray:[NoteViewModel] = [NoteViewModel]()
        for note in notes {
            var noteViewModel = NoteViewModel(model:note)
            resultArray.append(noteViewModel)
        }
        return resultArray
    }
}

extension ViewController: MusicTaskSelectNoteViewDelegate,MusicTaskSelectNoteInWordViewDelegate{
    func wrongAnswerReaction() {
        let alert = UIAlertController(title: "Неверный ответ", message: "Попробуй еще раз!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func rightAnswerReaction() {
        let alert = UIAlertController(title: "Верный ответ", message: "Поехали дальше!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ViewController: PianoViewDelegate {
    func keyTapped(withNotes:[(Note.NoteName,Note.Tonality)]) {
        let task8: MusicTaskShowNoteOnThePiano = tasksStorage.tasks[8] as! MusicTaskShowNoteOnThePiano
        let task8ViewModel = MusicTaskShowtNoteOnThePianoViewModel(model: task8)
        if task8ViewModel.checkUserAnswer(userAnswer: withNotes) {
            let alert = UIAlertController(title: "Верный ответ", message: "Поехали дальше!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Неверный ответ", message: "Попробуй еще раз!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}


