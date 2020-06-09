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
   
    var staffView: StaffView!
    var tasksStorage: MusicTasks!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = ViewController.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    var checkResultButton: UIButton = {
        var btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Проверить", for: .normal)
      //  btn.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
        btn.backgroundColor = .gray
        return btn
    }()
    
    var musicTaskSelectNoteView: MusicTaskSelectNoteView!
    var musicTaskShowNoteView: MusicTaskShowNoteOnThePianoView!
    
    override func viewDidAppear(_ animated: Bool) {
        let safeAreaLayoutFrame = view.safeAreaLayoutGuide.layoutFrame
        let safeAreaWidth = safeAreaLayoutFrame.width
        let safeAreaHeight = safeAreaLayoutFrame.height
 //<----------------------
        let task0: MusicTaskSelectNote = tasksStorage.tasks[0] as! MusicTaskSelectNote
        let task0ViewModel =  MusicTaskSelectNoteViewModel(model: task0)
        musicTaskSelectNoteView = MusicTaskSelectNoteView(
            viewModel: task0ViewModel,
            frame: CGRect(x: Int(safeAreaLayoutFrame.minX) + Int(TOP_OFFSET),
                          y: Int(safeAreaLayoutFrame.minY) + Int(LEFT_OFFSET),
                          width: Int(safeAreaWidth) - Int(LEFT_OFFSET) - Int(RIGHT_OFFSET),
                          height: Int(safeAreaHeight) - Int(TOP_OFFSET) - Int(BOTTOM_OFFSET)
                        )
        )
        musicTaskSelectNoteView.delegate = self
//        self.view.addSubview(musicTaskSelectNoteView)
//---------------------->
    
//        self.view.addSubview(questionLabel)
//        questionLabel.text = task0.questionText
//
//        questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: TOP_OFFSET).isActive = true
//        questionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_OFFSET).isActive = true
//        questionLabel.widthAnchor.constraint(equalToConstant: safeAreaWidth - LEFT_OFFSET*2).isActive = true
//        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: safeAreaWidth - LEFT_OFFSET*2 , font:ViewController.QUESTION_FONT))!).isActive = true
        
        
// 1 тип вопроса - выбрать ноты на нотном стане по заданным параметрам
//
//        staffView = StaffView(notesViewModels:convertNotesToViewModels(notes:task0.notesArray!),
//                              frame: CGRect(x:0, y:0, width:Int(safeAreaWidth)-30, height:StaffView.viewHeight()))
//        staffView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(staffView)
//        super.viewDidAppear(animated)
//        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
//        staffView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_OFFSET).isActive = true
//        staffView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -RIGHT_OFFSET).isActive = true
//        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
//        staffView.drawNotesOneByOne()
//
//        self.view.addSubview(checkResultButton)
//        checkResultButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_OFFSET).isActive = true
//        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: TOP_OFFSET).isActive = true
//        checkResultButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
//        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
//
    //<--------------
        let task8: MusicTaskShowNoteOnThePiano = tasksStorage.tasks[8] as! MusicTaskShowNoteOnThePiano
        let task8ViewModel = MusicTaskShowtNoteOnThePianoViewModel(model: task8)

        musicTaskShowNoteView = MusicTaskShowNoteOnThePianoView(
            viewModel: task8ViewModel,
            frame: CGRect(x: Int(safeAreaLayoutFrame.minX) + Int(TOP_OFFSET),
                          y: Int(safeAreaLayoutFrame.minY) + Int(LEFT_OFFSET),
                          width: Int(safeAreaWidth) - Int(LEFT_OFFSET) - Int(RIGHT_OFFSET),
                          height: Int(safeAreaHeight) - Int(TOP_OFFSET) - Int(BOTTOM_OFFSET)
                            )
        )

       // musicTaskShowNoteView.delegate = self
        musicTaskShowNoteView.pianoView.delegate = self
        self.view.addSubview(musicTaskShowNoteView)
// ---------------------->
        
 //2 тип вопроса - нажать на пианино клавишу, которая соответствует ноте на нотном стане
//        let pianoLeftOffset:CGFloat = 15.0
//        let staffViewWidth = (safeAreaWidth - LEFT_OFFSET - RIGHT_OFFSET - pianoLeftOffset)/2
//        let pianoViewWidth = staffViewWidth
//        let testNote = Note(name: .fa, tone: .none, duration: .whole)
//        let notes = convertNotesToViewModels(notes:[testNote])
//
//        staffView = StaffView(notesViewModels:notes,
//                              frame: CGRect(x:0, y:0, width:Int(safeAreaWidth/2), height:StaffView.viewHeight()))
//        staffView.translatesAutoresizingMaskIntoConstraints = false
//        staffView.isUserInteractionEnabled = false
//        self.view.addSubview(staffView)
//        super.viewDidAppear(animated)
//        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
//        staffView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_OFFSET).isActive = true
//        staffView.widthAnchor.constraint(equalToConstant: staffViewWidth).isActive = true
//        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
//        staffView.drawNotesOneByOne(notesAreTransparent: false)
//
//        let pianoView = PianoView(pianoWidth: pianoViewWidth, blackKeysOffset: 10.0, frame:CGRect.zero)
//        pianoView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(pianoView)
//        pianoView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
//        pianoView.rightAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.rightAnchor, constant: RIGHT_OFFSET).isActive = true
//        pianoView.widthAnchor.constraint(equalToConstant: pianoViewWidth).isActive = true
//        pianoView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tasksStorage = MusicTasks()
    }
    
//    @objc func checkButtonTapped(sender: UIButton) {
//        var alertTitleText = "Верный ответ"
//        var alertMessageText = "Так держать!"
//        var tappedSet = Set(staffView.pickedOutNotesIndexes)
//
//        let task0: MusicTaskSelectNote = tasksStorage.tasks[0] as! MusicTaskSelectNote
//        if !task0.checkUserAnswer(userAnswer: tappedSet) {
//            alertTitleText = "Неверный ответ"
//            alertMessageText = "Попробуйте еще раз!"
//        }
//        let alert = UIAlertController(title: alertTitleText, message: alertMessageText, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//        self.present(alert, animated: true)
//    }
    
    fileprivate func convertNotesToViewModels(notes:[Note]) -> [NoteViewModel] {
        var resultArray:[NoteViewModel] = [NoteViewModel]()
        for note in notes {
            var noteViewModel = NoteViewModel(model:note)
            resultArray.append(noteViewModel)
        }
        return resultArray
    }
}

extension ViewController: MusicTaskSelectNoteViewDelegate {
    func rightAnswerReaction() {
        let alert = UIAlertController(title: "Неверный ответ", message: "Попробуй еще раз!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func wrongAnswerReaction() {
        let alert = UIAlertController(title: "Верный ответ", message: "Поехали дельше!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ViewController: PianoViewDelegate {
    func keyTapped(withNotes:[(Note.NoteName,Note.Tonality)]) {
        let task8: MusicTaskShowNoteOnThePiano = tasksStorage.tasks[8] as! MusicTaskShowNoteOnThePiano
        let task8ViewModel = MusicTaskShowtNoteOnThePianoViewModel(model: task8)
        if task8ViewModel.checkUserAnswer(userAnswer: withNotes) {
            let alert = UIAlertController(title: "Верный ответ", message: "Поехали дельше!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Неверный ответ", message: "Попробуй еще раз!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}


