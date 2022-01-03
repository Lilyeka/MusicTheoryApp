//
//  QuizSelectNoteInWordCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 18.08.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizSelectNoteInWordCollectionViewCell: UICollectionViewCell {
    
    static let WORD_FONT = UIFont.systemFont(ofSize: 35, weight: .bold)
    
    let STAF_HORIZ_OFSET: CGFloat = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 25.0//15.0
        } else {
            return 20.0//10.0
        }
    }()
    
    //MARK: -Delegate
    var delegate: QuizSelectAnswerDelegate?
    
    //MARK: -ViewModel
    var viewModel: MusicTaskSelectNoteInWordViewModel!
    
    //MARK: -Views
    var staffView: StaffView!
    var wordStackView: UIStackView!
    var partsOfWordLables: [UILabel] = [UILabel]()
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = QuizSelectNoteInWordCollectionViewCell.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 1
        label.layer.zPosition = .greatestFiniteMagnitude
        return label
    }()
    
    //MARK: -Init
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Public methods
    func configureSubviews(viewModel: MusicTaskSelectNoteInWordViewModel, frame: CGRect) {
        self.contentView.backgroundColor = .white
        self.viewModel = viewModel
        
        let staffViewBigOctaveBottomOffset: CGFloat = viewModel.areNotesInBigOrFirstOctave() ? -40.0 : 0.0
        
        self.questionLabel.text = viewModel.model.questionText
        self.contentView.addSubview(questionLabel)
        
        self.staffView = StaffView(notesViewModels:viewModel.notesViewModels,
                              selectOnlyOneNote: true,
                              frame: CGRect.zero,
                              notesDelegate: self,
                              cleff: viewModel.model.cleffType)
        self.staffView.translatesAutoresizingMaskIntoConstraints = false
        self.staffView.delegate = self
        self.contentView.addSubview(self.staffView)
        self.staffView.drawNotesOneByOne1(notesAreTransparent: true, viewWidth: self.contentView.frame.width - STAF_HORIZ_OFSET*2)
        
        for partOfWord in viewModel.model.partsOfWord {
            let label = UILabel()
            label.text = partOfWord.0
            label.textColor = .black
            label.font = QuizSelectNoteInWordCollectionViewCell.WORD_FONT
            partsOfWordLables.append(label)
        }
        
        self.wordStackView = UIStackView(arrangedSubviews: self.partsOfWordLables)
        self.wordStackView.translatesAutoresizingMaskIntoConstraints = false
        self.wordStackView.axis = .horizontal
        self.wordStackView.distribution = .fill
        self.wordStackView.alignment = .center
        self.contentView.addSubview(wordStackView)
        
        NSLayoutConstraint.activate([
            self.questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0),
            self.questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15.0),
            self.questionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15.0),
            
            self.staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: STAF_HORIZ_OFSET),
            self.staffView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -STAF_HORIZ_OFSET),
            self.staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())),
            self.staffView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: staffViewBigOctaveBottomOffset),
            
            self.wordStackView.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor),
            self.wordStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    override func prepareForReuse() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        partsOfWordLables = [UILabel]()
        staffView = nil
        viewModel = nil
        wordStackView = nil
    }
}

//MARK: -NoteViewModelDelegate
extension QuizSelectNoteInWordCollectionViewCell: NoteViewModelDelegate {
    func noteTaped(noteName: Note.NoteName, noteView: UIView) {
        if let viewModel = viewModel {
            if (viewModel.noteIsFromRightAnswer(note: noteName)) {
                delegate?.additionalRightAnswerReaction(view: noteView)
            }
        }
    }
}

//MARK: -StaffViewDelegate
extension QuizSelectNoteInWordCollectionViewCell: StaffViewDelegate {
    func pickedOutNotesIndexesDidChange(newValue: [Int]) {
        if (viewModel.checkUserAnswer1(userAnswer: newValue)) {
            delegate?.rightAnswerReaction()
        }
    }
}
