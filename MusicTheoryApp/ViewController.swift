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
    
    var staffView: StaffView!
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        let note1 = NoteViewModel(model:Note(name:.Do, tone:.none, duration:.whole))
        let note2 = NoteViewModel(model:Note(name:.re, tone:.none, duration:.whole))
        let note3 = NoteViewModel(model:Note(name:.mi, tone:.none, duration:.whole))
        let note4 = NoteViewModel(model:Note(name:.fa, tone:.none, duration:.whole))
        let note5 = NoteViewModel(model:Note(name:.sol, tone:.none, duration:.whole))
        let note6 = NoteViewModel(model:Note(name:.la, tone:.none, duration:.whole))
        let note7 = NoteViewModel(model:Note(name:.la1, tone:.none, duration:.whole))
        let questionText = "Отметьте ноты, расположенные на основных нотных линейках"
        self.view.addSubview(questionLabel)
        questionLabel.text = questionText
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
