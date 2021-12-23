//
//  QuizShowNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 13.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizShowNoteCollectionViewCell: UICollectionViewCell {

    let TOP_OFFSET: CGFloat = 15.0
    let LEFT_OFFSET: CGFloat = 15.0
   
    //MARK: -Delegate
    var delegate: QuizSelectAnswerDelegate?
        
    //MARK: -Views
    var viewModel: MusicTaskShowtNoteOnThePianoViewModel?
    var staffView: StaffView!
    var pianoView: PianoView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = QuizShowNoteCollectionViewCell.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
        
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Public methods
    func configureSubViews(viewModel: MusicTaskShowtNoteOnThePianoViewModel, frame: CGRect) {
        self.viewModel = viewModel
        
        self.contentView.addSubview(self.questionLabel)
        self.questionLabel.text = viewModel.model.questionText
        self.questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        self.questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        self.questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width-2*LEFT_OFFSET).isActive = true
        self.questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizShowNoteCollectionViewCell.QUESTION_FONT))!).isActive = true

        let staffViewWidth = 1*(frame.size.width - 3*LEFT_OFFSET)/3
        let pianoViewWidth = 2*(frame.size.width - 3*LEFT_OFFSET)/3
        
        self.staffView = StaffView(
            notesViewModels: viewModel.notesViewModels,
            selectOnlyOneNote: true,
            frame: CGRect.zero,
            notesDelegate: nil,
            cleff: viewModel.model.cleffType)
        self.staffView.translatesAutoresizingMaskIntoConstraints = false
        self.staffView.isUserInteractionEnabled = false
        
        self.contentView.addSubview(self.staffView)
        self.staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 0.0).isActive = true
        self.staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        self.staffView.widthAnchor.constraint(equalToConstant: staffViewWidth).isActive = true
        self.staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne1(notesAreTransparent: false, viewWidth: staffViewWidth)
        
        self.pianoView = PianoView(pianoWidth: pianoViewWidth, blackKeysOffset: 20.0, frame:CGRect.zero)
        self.pianoView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.pianoView)
        self.pianoView.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        self.pianoView.leftAnchor.constraint(equalTo: self.staffView.rightAnchor, constant: LEFT_OFFSET*2).isActive = true
        self.pianoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -LEFT_OFFSET).isActive = true
        self.pianoView.heightAnchor.constraint(equalTo: self.staffView.heightAnchor).isActive = true
    }
    
    //MARK: -Override methods
    override func prepareForReuse() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
}

