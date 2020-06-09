//
//  MusicTaskShowNoteOnThePianoView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 08.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MusicTaskShowNoteOnThePianoViewDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
}


class MusicTaskShowNoteOnThePianoView: UIView {
    
    let TOP_OFFSET: CGFloat = 15.0
    let LEFT_OFFSET: CGFloat = 15.0
    let RIGHT_OFFSET: CGFloat = 15.0
    let LABEL_HEIGHT: CGFloat = 45.0
    
    var viewModel: MusicTaskShowtNoteOnThePianoViewModel?
    var staffView: StaffView!
    var pianoView: PianoView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = MusicTaskSelectNoteViewModel.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
    
    init(viewModel: MusicTaskShowtNoteOnThePianoViewModel, frame:CGRect) {
        super.init(frame: frame)
        self.viewModel = viewModel
        setupSubViews(withFrame:frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubViews(withFrame:CGRect) {
        self.backgroundColor = .green
        
        self.addSubview(questionLabel)
        questionLabel.text = viewModel?.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: withFrame.size.width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: withFrame.size.width, font:MusicTaskSelectNoteViewModel.QUESTION_FONT))!).isActive = true
    
        let pianoLeftOffset:CGFloat = 20.0
        let staffViewWidth = (withFrame.size.width - pianoLeftOffset)/2
        let pianoViewWidth = staffViewWidth

        staffView = StaffView(notesViewModels:viewModel!.notesViewModels,
                              frame: CGRect(x:0, y:0, width:Int(staffViewWidth), height:StaffView.viewHeight()))
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        self.addSubview(staffView)
    
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        staffView.widthAnchor.constraint(equalToConstant: staffViewWidth).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne(notesAreTransparent: false)
        
        pianoView = PianoView(pianoWidth: pianoViewWidth, blackKeysOffset: 10.0, frame:CGRect.zero)
        pianoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pianoView)
        pianoView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        pianoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        pianoView.widthAnchor.constraint(equalToConstant: pianoViewWidth).isActive = true
        pianoView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        self.addSubview(checkResultButton)
        checkResultButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: TOP_OFFSET).isActive = true
        checkResultButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
//        let tappedSet = Set(staffView.pickedOutNotesIndexes)
//        if (viewModel?.checkUserAnswer(userAnswer: tappedSet))! {
//            delegate?.wrongAnswerReaction()
//        } else {
//            delegate?.rightAnswerReaction()
 //       }
    }
}
