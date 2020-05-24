//
//  ViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 29.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let TOP_OFFSET: CGFloat = 15.0
    let LEFT_OFFSET: CGFloat = 15.0
    let RIGHT_OFFSET: CGFloat = 15.0
    let LABEL_HEIGHT: CGFloat = 45.0
    let rightAnsverSet: Set<Int> = [2,4,6]
    var staffView: StaffView!
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        label.text = "Отметьте ноты, расположенные на основных нотных линейках"
        return label
    }()
    var checkResultButton: UIButton = {
        var btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Проверить", for: .normal)
        btn.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
        btn.backgroundColor = .gray
        return btn
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        let note1 = NoteViewModel(model:Note(name:.Do, tone:.none, duration:.whole))
        let note2 = NoteViewModel(model:Note(name:.re, tone:.none, duration:.whole))
        let note3 = NoteViewModel(model:Note(name:.mi, tone:.none, duration:.whole))
        let note4 = NoteViewModel(model:Note(name:.fa, tone:.none, duration:.whole))
        let note5 = NoteViewModel(model:Note(name:.sol, tone:.none, duration:.whole))
        let note6 = NoteViewModel(model:Note(name:.la, tone:.none, duration:.whole))
        let note7 = NoteViewModel(model:Note(name:.si, tone:.none, duration:.whole))
    
        self.view.addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: TOP_OFFSET).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_OFFSET).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -RIGHT_OFFSET).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: LABEL_HEIGHT).isActive = true
        
        let safeAreaLayoutFrame = view.safeAreaLayoutGuide.layoutFrame
        let safeAreaWidth = safeAreaLayoutFrame.width
        
        staffView = StaffView(notesViewModels: [note1,note2,note3,note4,note5,note6,note7],
                              frame: CGRect(x:0, y:0, width:Int(safeAreaWidth)-30, height:StaffView.viewHeight()))
        staffView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(staffView)
        super.viewDidAppear(animated)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        staffView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_OFFSET).isActive = true
        staffView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -RIGHT_OFFSET).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne()
        
        self.view.addSubview(checkResultButton)
        checkResultButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_OFFSET).isActive = true
        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: TOP_OFFSET).isActive = true
        checkResultButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        var alertTitleText = "Верный ответ"
        var alertMessageText = "Так держать!"
        var tappedSet = Set(staffView.pickedOutNotesIndexes)
        if tappedSet != rightAnsverSet {
                alertTitleText = "Неверный ответ"
                alertMessageText = "Попробуйте еще раз!"
        }
        let alert = UIAlertController(title: alertTitleText, message: alertMessageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       // alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
}
