//
//  MusicTaskSelectNoteInWordView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MusicTaskSelectNoteInWordViewDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
}

class MusicTaskSelectNoteInWordView: UIView {
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 16.0)
    //MARK: -Delegate
    var delegate: MusicTaskSelectNoteInWordViewDelegate?
    
    var viewModel: MusicTaskSelectNoteInWordViewModel!
    var staffView: StaffView!
    var wordStackView: UIStackView!
    var partsOfWordLables: [UILabel] = [UILabel]()

    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = MusicTaskSelectNoteInWordView.QUESTION_FONT
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

    init(viewModel:MusicTaskSelectNoteInWordViewModel, frame:CGRect) {
        super.init(frame: frame)
        self.viewModel = viewModel
        setupSubviews(withFrame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(withFrame:CGRect) {
        self.addSubview(questionLabel)
        questionLabel.text = viewModel?.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: withFrame.size.width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: withFrame.size.width, font:MusicTaskShowNoteOnThePianoView.QUESTION_FONT))!).isActive = true
        
        var i = 0
        while i < viewModel.model.partsOfWord!.count {
            let label = UILabel()
            label.text = viewModel.model.partsOfWord![i].0
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
            partsOfWordLables.append(label)
            i += 1
        }
        
        wordStackView = UIStackView(arrangedSubviews: partsOfWordLables)
        wordStackView.translatesAutoresizingMaskIntoConstraints = false
        wordStackView.axis = .horizontal
        wordStackView.distribution = .fill
        wordStackView.alignment = .center
        self.addSubview(wordStackView)
        wordStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15.0).isActive = true
        wordStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        staffView = StaffView(notesViewModels:viewModel!.notesViewModels,
                              frame: CGRect(x:0, y:0, width:Int(withFrame.size.width*0.9), height:StaffView.viewHeight()))
        staffView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(staffView)
        
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15.0).isActive = true
        staffView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        staffView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne(notesAreTransparent: true)
        
        self.addSubview(checkResultButton)
        checkResultButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: 15.0).isActive = true
        checkResultButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        let tappedNotesNumbers = staffView.pickedOutNotesIndexes
        if (viewModel?.checkUserAnswer1(userAnswer: tappedNotesNumbers))! {
            delegate?.rightAnswerReaction()
        } else {
            delegate?.wrongAnswerReaction()
        }
    }
}
