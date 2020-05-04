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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        staffView = StaffView(frame: CGRect(x: 0, y: 250, width: Int(self.view.frame.size.width), height: StaffView.viewHeight()))
        self.view.addSubview(staffView)
        
        let note1 = Note(name:.fa1, tone: .dies, duration:.none)
        let note2 = Note(name:.Do1, tone: .dies, duration:.none)
        let note3 = Note(name:.sol1, tone: .dies, duration:.none)
        let note4 = Note(name:.re1, tone: .dies, duration:.none)
 // 
        staffView.drawNotes(notes:[note1, note2, note3, note4])
//        staffView.layoutIfNeeded()
        
       // staffView.layoutSubviews()
    }
    


}
