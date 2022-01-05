//
//  QuizSelectNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 13.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizSelectNoteCollectionViewCell: UICollectionViewCell {
    //MARK: -Delegate
    var delegate: QuizSelectAnswerDelegate?
    
    //MARK: -ViewModel
    var viewModel: MusicTaskSelectNoteViewModel?
    
    //MARK: -Views
    var staffView: StaffView!
    var questionLabel: UILabel!
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Public methods
    func configureSubviews(viewModel: MusicTaskSelectNoteViewModel, frame: CGRect) {
        self.viewModel = viewModel
        //дельта, которая становится больше нуля в случае, если все ноты viewModel.notesViewModels выше Do1
        let additionalTopOffsetForStaffView: CGFloat = {
            if let octave = viewModel.notesOctave(), octave == .TrebleSecond {
                return addTopOffsetForStaffView()
            }
            return 0.0
        }()
        self.questionLabel = UILabel()
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.questionLabel.backgroundColor = .clear
        self.questionLabel.textColor = .black
        self.questionLabel.font = QuizSelectNoteCollectionViewCell.QUESTION_FONT
        self.questionLabel.lineBreakMode = .byWordWrapping
        self.questionLabel.numberOfLines = 0
        self.questionLabel.textAlignment = .center
        self.questionLabel.text = viewModel.model.questionText
        
        self.staffView = StaffView(notesViewModels: viewModel.notesViewModels,
                                   selectOnlyOneNote: false,
                                   frame: CGRect.zero,
                                   notesDelegate: self,
                                   cleff: viewModel.model.cleffType)
        self.staffView.delegate = self
        self.staffView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(staffView)
        
        self.staffView.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: QuizSelectNoteCollectionViewCell.STAF_TOP_OFFSET + additionalTopOffsetForStaffView).isActive = true
        self.staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: QuizSelectNoteCollectionViewCell.STAF_VERT_OFFSET).isActive = true
        self.staffView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -QuizSelectNoteCollectionViewCell.STAF_VERT_OFFSET).isActive = true
        self.staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        self.staffView.drawNotesOneByOne1(notesAreTransparent: true, viewWidth: self.contentView.frame.width)
        
        self.contentView.addSubview(self.questionLabel)
        self.questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: QuizSelectNoteCollectionViewCell.LBL_TOP_OFFSET).isActive = true
        self.questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25).isActive = true
        self.questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 50).isActive = true
        self.questionLabel.heightAnchor.constraint(equalToConstant: (self.questionLabel.text?.height(width: frame.size.width - 50, font:QuizSelectNoteCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        questionLabel.superview!.bringSubviewToFront(questionLabel)
    }
    
    //MARK: -Override methods
    override func prepareForReuse() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
    
    //MARK: -Private methods
    func addTopOffsetForStaffView() -> CGFloat {
        if DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 25.0
        }
        
        if DeviceType.IS_IPHONE_12ProMax_13ProMax {
            return 55.0
        }
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 21.0
        }
        if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            return 15.0
        }
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            return 12.0
        }
        return 13.0
    }
}

extension QuizSelectNoteCollectionViewCell: NoteViewModelDelegate {
    func noteTaped(noteName: Note.NoteName, noteView: UIView) {
        if let viewModel = viewModel {
            if viewModel.noteIsFromRightAnswer(note: noteName) {
                //delegate?.rightNoteTappedReaction(noteView: noteView)
                delegate?.additionalRightAnswerReaction(view: noteView)
            }
        }
    }
}

extension QuizSelectNoteCollectionViewCell: StaffViewDelegate {
    
    func pickedOutNotesIndexesDidChange(newValue: [Int]) {
        if newValue.count > 0 {
            var noteNamesArray = [Note.NoteName]()
            
            for n in newValue {
                if let noteName = Note.NoteName(rawValue: n) {
                    noteNamesArray.append(noteName)
                }
            }
            noteNamesArray.sort{$0.rawValue < $1.rawValue}
            if (viewModel?.checkUserAnswer(userAnswer: noteNamesArray))! {
                delegate?.rightAnswerReaction()
            }
        }
    }
}

extension QuizSelectNoteCollectionViewCell {
    static let LBL_TOP_OFFSET: CGFloat = 10.0
    
    static let STAF_TOP_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_11Pro_X_Xs || DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 30.0
        } else if DeviceType.IS_IPHONE_12ProMax_13ProMax {
            return 20.0
        }
        return 45.0
    }()
    
    static let STAF_VERT_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax ||
            DeviceType.IS_IPHONE_12_12Pro_13_13Pro ||
            DeviceType.IS_IPHONE_12ProMax_13ProMax {
            return 15.0
        } else {
            return 10.0
        }
    }()
}
