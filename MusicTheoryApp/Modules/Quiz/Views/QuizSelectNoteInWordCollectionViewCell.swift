//
//  QuizSelectNoteInWordCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 18.08.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol QuizSelectNoteInWordCollectionViewCellDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
    func rightNoteTappedReaction(noteView: UIView)
}

class QuizSelectNoteInWordCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 18.0)
    static let WORD_FONT = UIFont.systemFont(ofSize: 35, weight: .bold)
    
    let STAF_VERT_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 15.0
        } else {
            return 10.0
        }
    }()
    
    //MARK: -Delegate
    var delegate: QuizSelectNoteInWordCollectionViewCellDelegate?
    
    //MARK: -Views
    var viewModel: MusicTaskSelectNoteInWordViewModel!
    var staffView: StaffView!
    var wordStackView: UIStackView!
    var partsOfWordLables: [UILabel] = [UILabel]()
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = QuizSelectNoteInWordCollectionViewCell.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: -Init
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func configureSubviews(viewModel:MusicTaskSelectNoteInWordViewModel, frame:CGRect) {
        self.viewModel = viewModel
        self.addSubview(questionLabel)
        questionLabel.text = viewModel.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15.0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 30.0).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizSelectNoteInWordCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        staffView = StaffView(notesViewModels:viewModel.notesViewModels,
                              selectOnlyOneNote: false,
                              frame: CGRect.zero,
                              notesDelegate: nil,
                              cleff: viewModel.model.cleffType)
        staffView.setNotesDelegate(deleg: self)
        staffView.delegate = self
        staffView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo:questionLabel.bottomAnchor, constant: 15.0).isActive = true
        staffView.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant: STAF_VERT_OFFSET).isActive = true
        staffView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -STAF_VERT_OFFSET).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne1(notesAreTransparent: true, viewWidth: self.contentView.frame.width)
        
        var i = 0
        while i < viewModel.model.partsOfWord!.count {
            let label = UILabel()
            label.text = viewModel.model.partsOfWord![i].0
            label.textColor = .black
            label.font = QuizSelectNoteInWordCollectionViewCell.WORD_FONT
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
        wordStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        partsOfWordLables = [UILabel]()
    }
}

extension QuizSelectNoteInWordCollectionViewCell: NoteViewModelDelegate {
    func noteTaped(noteName: Note.NoteName, noteView: UIView) {
        if let viewModel = viewModel {
            if (viewModel.noteIsFromRightAnswer(note: noteName)) {
                delegate?.rightNoteTappedReaction(noteView: noteView)
            }
        }
    }
}

extension QuizSelectNoteInWordCollectionViewCell: StaffViewDelegate {
    func pickedOutNotesIndexesDidChange(newValue: [Int]) {
        if (viewModel.checkUserAnswer1(userAnswer: newValue)) {
            delegate?.rightAnswerReaction()
        }
    }
}
