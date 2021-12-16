//
//  QuizShowNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 13.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

//protocol QuizShowNoteCollectionViewCellDelegate {
//    func rightAnswerReaction()
//    func wrongAnswerReaction()
//}

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
    func configureSubViews(viewModel: MusicTaskShowtNoteOnThePianoViewModel,frame:CGRect) {
        self.viewModel = viewModel
        
        self.contentView.addSubview(questionLabel)
        questionLabel.text = viewModel.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: TOP_OFFSET).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width-2*LEFT_OFFSET).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizShowNoteCollectionViewCell.QUESTION_FONT))!).isActive = true

        let staffViewWidth = 1*(frame.size.width - 3*LEFT_OFFSET)/3
        let pianoViewWidth = 2*(frame.size.width - 3*LEFT_OFFSET)/3
        
        staffView = StaffView(notesViewModels:viewModel.notesViewModels,
                              selectOnlyOneNote: true,
                              frame: CGRect.zero,
                              notesDelegate: nil,
                              cleff: viewModel.model.cleffType)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        self.contentView.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        staffView.widthAnchor.constraint(equalToConstant: staffViewWidth).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne1(notesAreTransparent: false, viewWidth: staffViewWidth)
        
        pianoView = PianoView(pianoWidth: pianoViewWidth, blackKeysOffset: 20.0, frame:CGRect.zero)
        pianoView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(pianoView)
        pianoView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        pianoView.leftAnchor.constraint(equalTo: staffView.rightAnchor, constant: LEFT_OFFSET*2).isActive = true
        pianoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: LEFT_OFFSET).isActive = true
        pianoView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
    }
    
    //MARK: -Override methods
    override func prepareForReuse() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
}

