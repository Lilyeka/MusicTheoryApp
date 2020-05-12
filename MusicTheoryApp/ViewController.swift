//
//  ViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 29.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var staffView: StaffView!
    
    override func viewDidAppear(_ animated: Bool) {
        let safeAreaLayoutFrame = view.safeAreaLayoutGuide.layoutFrame
        let safeAreaWidth = safeAreaLayoutFrame.width
        
        staffView = StaffView(frame: CGRect(x:0, y:0, width:Int(safeAreaWidth)-30, height:StaffView.viewHeight()))
        staffView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(staffView)
        super.viewDidAppear(animated)
        staffView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15.0).isActive = true
        staffView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15.0).isActive = true
        staffView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15.0).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.layoutSubviews()
        
        let note1 = NoteViewModel(model:Note(name:.Do, tone:.none, duration:.whole))
        let note2 = NoteViewModel(model:Note(name:.re, tone:.none, duration:.whole))
        let note3 = NoteViewModel(model:Note(name:.mi, tone:.none, duration:.whole))
        let note4 = NoteViewModel(model:Note(name:.fa, tone:.none, duration:.whole))
        let note5 = NoteViewModel(model:Note(name:.sol, tone:.none, duration:.whole))
        let note6 = NoteViewModel(model:Note(name:.la, tone:.none, duration:.whole))
        let note7 = NoteViewModel(model:Note(name:.si, tone:.none, duration:.whole))
        //
        staffView.drawNotesOneByOne(notes:[note1,note2,note3,note4,note5,note6,note7])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    


}
