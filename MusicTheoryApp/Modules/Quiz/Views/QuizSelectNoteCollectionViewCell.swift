//
//  QuizSelectNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 13.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol QuizSelectNoteCollectionViewCellDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
}

class QuizSelectNoteCollectionViewCell: UICollectionViewCell {
    public static var cellIdentifier: String {
        return String(describing: self)
    }
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 20.0)
    let BTN_TOP_OFFSET: CGFloat = 25.0
    let LBL_TOP_OFFSET: CGFloat = 10.0
    
    //MARK: -Delegate
    var delegate: QuizSelectNoteCollectionViewCellDelegate?
    
    //MARK: -Views
    var viewModel: MusicTaskSelectNoteViewModel?
    var staffView: StaffView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = MusicTaskSelectNoteView.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var checkResultButton: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Проверить", for: .normal)
        btn.backgroundColor = .blue
        return btn
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
                
        staffView = StaffView(notesViewModels: viewModel.notesViewModels,selectOnlyOneNote: false, frame:CGRect.zero)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: LBL_TOP_OFFSET).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25).isActive = true
        staffView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 25).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne(notesAreTransparent: true)
        
        self.contentView.addSubview(questionLabel)
        questionLabel.text = viewModel.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: LBL_TOP_OFFSET).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:MusicTaskSelectNoteView.QUESTION_FONT))!).isActive = true
        questionLabel.superview!.bringSubviewToFront(questionLabel)
        
        self.addSubview(checkResultButton)
        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: BTN_TOP_OFFSET).isActive = true
        checkResultButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true

        //checkResultButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        checkResultButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
    }
    
    //MARK: -Actions
    @objc func checkButtonTapped(sender: UIButton) {
        let tappedSet = Set(staffView.pickedOutNotesIndexes)
        if (viewModel?.checkUserAnswer(userAnswer: tappedSet))! {
            delegate?.rightAnswerReaction()
        } else {
            delegate?.wrongAnswerReaction()
        }
    }
    //MARK: -Override methods
    override func prepareForReuse() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
}
