//
//  QuizSelectNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 13.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

//protocol QuizSelectNoteCollectionViewCellDelegate {
//    func rightAnswerReaction()
//    func wrongAnswerReaction()
//    func additionalRightAnswerReaction(view: UIView)
//   // func rightNoteTappedReaction(noteView: UIView)
//}

class QuizSelectNoteCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    static let QUESTION_FONT: UIFont = {
         if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
             return UIFont.boldSystemFont(ofSize: 23.0)
         }
         return UIFont.boldSystemFont(ofSize: 20.0)
     }()
    
    let LBL_TOP_OFFSET: CGFloat = 10.0
    let STAF_TOP_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_11Pro_X_Xs || DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 30.0
        }
        return 45.0
    }()
    
    let STAF_VERT_OFFSET: CGFloat = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return 15.0
        } else {
            return 10.0
        }
    }()
    
    //MARK: -Delegate
    var delegate: QuizSelectAnswerDelegate?
    
    //MARK: -ViewModel
    var viewModel: MusicTaskSelectNoteViewModel?
    
    //MARK: -Views
    var staffView: StaffView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = QuizSelectNoteCollectionViewCell.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
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
    func configureSubviews(viewModel:MusicTaskSelectNoteViewModel, frame:CGRect) {
        self.viewModel = viewModel
        //дельта, которая становится больше нуля в случае, если все ноты viewModel.notesViewModels выше Do1
        let additionalTopOffsetForStaffView: CGFloat = {
            if let octave = viewModel.notesOctave(), octave == .TrebleSecond {
                return addTopOffsetForStaffView()
            }
            return 0.0
        }()
        
        staffView = StaffView(notesViewModels: viewModel.notesViewModels,
                              selectOnlyOneNote: false,
                              frame: CGRect.zero,
                              notesDelegate: self,
                              cleff: viewModel.model.cleffType)
        staffView.delegate = self
        staffView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(staffView)
        
        staffView.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: STAF_TOP_OFFSET + additionalTopOffsetForStaffView).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: STAF_VERT_OFFSET).isActive = true
        staffView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -STAF_VERT_OFFSET).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne1(notesAreTransparent: true, viewWidth: self.contentView.frame.width)
        
        questionLabel.text = viewModel.model.questionText
        self.contentView.addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: LBL_TOP_OFFSET).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 50).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width - 50, font:QuizSelectNoteCollectionViewCell.QUESTION_FONT))!).isActive = true
        
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
            return 17.0
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
        return 0.0
    }
}

extension QuizSelectNoteCollectionViewCell: NoteViewModelDelegate {
    func noteTaped(noteName: Note.NoteName, noteView: UIView) {
        if let viewModel = viewModel {
            if viewModel.noteIsFromRightAnswer(note:noteName) {
                //delegate?.rightNoteTappedReaction(noteView: noteView)
                delegate?.additionalRightAnswerReaction(view: noteView)
            }
        }
    }
}

extension QuizSelectNoteCollectionViewCell: StaffViewDelegate {
    func pickedOutNotesIndexesDidChange(newValue: [Int]) {
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
