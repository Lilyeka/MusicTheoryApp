//
//  QuizShowNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 13.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol QuizShowNoteCollectionViewCellDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
   // func pianoKeyTapped(withNotes: [(Note.NoteName, Note.Tonality)])
}

class QuizShowNoteCollectionViewCell: UICollectionViewCell {
    public static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 20.0)
    let TOP_OFFSET: CGFloat = 15.0
    let LEFT_OFFSET: CGFloat = 15.0
    let RIGHT_OFFSET: CGFloat = 15.0
    
    //MARK: -Delegate
    var delegate: QuizShowNoteCollectionViewCellDelegate?
    
    //MARK: -Views
    var viewModel: MusicTaskShowtNoteOnThePianoViewModel?
    var staffView: StaffView!
    var pianoView: PianoView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = MusicTaskShowNoteOnThePianoView.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
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
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:MusicTaskShowNoteOnThePianoView.QUESTION_FONT))!).isActive = true
        
        let pianoLeftOffset:CGFloat = 20.0
        let staffViewWidth = (frame.size.width - pianoLeftOffset)/2
        let pianoViewWidth = staffViewWidth
        
        staffView = StaffView(notesViewModels:viewModel.notesViewModels,selectOnlyOneNote: true,
                              frame: CGRect.zero, notesDelegate: nil)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        self.contentView.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0).isActive = true
        staffView.widthAnchor.constraint(equalToConstant: staffViewWidth).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne(notesAreTransparent: false)
        
        pianoView = PianoView(pianoWidth: pianoViewWidth, blackKeysOffset: 10.0, frame:CGRect.zero)
        pianoView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(pianoView)
        pianoView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        pianoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0).isActive = true
        pianoView.widthAnchor.constraint(equalToConstant: pianoViewWidth).isActive = true
        pianoView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
      //  pianoView.delegate = self
    }
    
    //MARK: -Override methods
    override func prepareForReuse() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
}

//extension QuizShowNoteCollectionViewCell: PianoViewDelegate {
//    func keyTapped(withNotes: [(Note.NoteName, Note.Tonality)]) {
//        self.delegate?.pianoKeyTapped(withNotes: <#T##[(Note.NoteName, Note.Tonality)]#>)
//    }
//
//
//}
