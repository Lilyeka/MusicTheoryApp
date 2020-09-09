//
//  MusicTaskSelectNoteView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 05.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MusicTaskSelectNoteViewDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
}

class MusicTaskSelectNoteView: UIView {
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 16.0)
    
    //MARK: -Delegate
    var delegate: MusicTaskSelectNoteViewDelegate?
    
    let TOP_OFFSET: CGFloat = 15.0
    let LEFT_OFFSET: CGFloat = 15.0
    let RIGHT_OFFSET: CGFloat = 15.0
    let LABEL_HEIGHT: CGFloat = 45.0
    
    var viewModel: MusicTaskSelectNoteViewModel?
    var staffView: StaffView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = MusicTaskSelectNoteView.QUESTION_FONT
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
    
    init(viewModel: MusicTaskSelectNoteViewModel, frame:CGRect) {
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
        self.addSubview(questionLabel)
        questionLabel.text = viewModel?.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: withFrame.size.width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: withFrame.size.width, font:MusicTaskSelectNoteView.QUESTION_FONT))!).isActive = true
        
        staffView = StaffView(notesViewModels: viewModel!.notesViewModels,
                              selectOnlyOneNote: false,
                              frame: CGRect.zero,
                              notesDelegate: nil,
                              cleff: viewModel!.model.cleffType)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 0).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        staffView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne(notesAreTransparent: true)
        
        self.addSubview(checkResultButton)
        checkResultButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: TOP_OFFSET).isActive = true
        checkResultButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        var tappedArray = [Note.NoteName]()
        for n in staffView.pickedOutNotesIndexes {
            if let noteName = Note.NoteName(rawValue: n) {
                tappedArray.append(noteName)
            }
        }
        tappedArray.sort{$0.rawValue < $1.rawValue}
        if (viewModel?.checkUserAnswer(userAnswer: tappedArray))! {
            delegate?.rightAnswerReaction()
        } else {
           delegate?.wrongAnswerReaction()
        }
    }
}
