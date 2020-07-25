//
//  QuizWriteNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 14.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol QuizWriteNoteCollectionViewCellDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
}

class QuizWriteNoteCollectionViewCell: UICollectionViewCell {
    public static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 20.0)
    static let WORD_FONT = UIFont.boldSystemFont(ofSize: 35.0)
    static let TEXTFIELD_LETTER_WIDTH = 30
    
    //MARK: -Delegate
    var delegate: QuizWriteNoteCollectionViewCellDelegate?
    
    //MARK: -UI Elements
    var viewModel: MusicTaskWriteNoteInWordViewModel!
    var staffView: StaffView!
    var wordStackView: UIStackView!
    var partsOfWordViews: [UIView] = [UIView]()
    var numberOfLettersInTextField = 0
    
    var bgButton: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = MusicTaskWriteNoteInWordView.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var textField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = ""
        textField.font = MusicTaskWriteNoteInWordView.WORD_FONT
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.alphabet
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        return textField
    }()
    
    var checkResultButton: UIButton = {
        var btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Проверить", for: .normal)
        btn.backgroundColor = .gray
        return btn
    }()
    
    //MARK: -Init
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func configureSubviews(viewModel:MusicTaskWriteNoteInWordViewModel, frame:CGRect) {
        self.backgroundView = UIImageView(image: UIImage(named: "background"))
        self.viewModel = viewModel
        
        self.contentView.addSubview(bgButton)
        bgButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bgButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bgButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bgButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bgButton.addTarget(self, action: #selector(bgButtonTapped(sender:)), for: .touchUpInside)
        
        self.contentView.addSubview(questionLabel)
        questionLabel.text = viewModel.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:MusicTaskShowNoteOnThePianoView.QUESTION_FONT))!).isActive = true
        
        staffView = StaffView(notesViewModels:viewModel.notesViewModels,
                              selectOnlyOneNote: true,
                              frame: CGRect.zero)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        staffView.clipsToBounds = true
        self.contentView.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15.0).isActive = true
        staffView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6).isActive = true
        staffView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne(notesAreTransparent: false)
        
        var i = 0
        while i < viewModel.model.partsOfWord!.count {
            if let note = viewModel.model.partsOfWord![i].1 {
                numberOfLettersInTextField = note.noteRusName().count
                let textFieldWidth: CGFloat = CGFloat(numberOfLettersInTextField * MusicTaskWriteNoteInWordView.TEXTFIELD_LETTER_WIDTH)
                textField.delegate = self
                textField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
                partsOfWordViews.append(textField)
            } else {
                let label = UILabel()
                label.text = viewModel.model.partsOfWord![i].0
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
                partsOfWordViews.append(label)
            }
            i += 1
        }
        wordStackView = UIStackView(arrangedSubviews: partsOfWordViews)
        wordStackView.translatesAutoresizingMaskIntoConstraints = false
        wordStackView.axis = .horizontal
        wordStackView.distribution = .fill
        wordStackView.spacing = 5.0
        wordStackView.alignment = .center
        
        self.contentView.addSubview(wordStackView)
        wordStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15.0).isActive = true
        wordStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
        
        self.contentView.addSubview(checkResultButton)
        checkResultButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: 15.0).isActive = true
        checkResultButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        checkResultButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        viewModel = nil
        partsOfWordViews = [UIView]()
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        if let userAnswerText = textField.text {
            print(userAnswerText)
            if (viewModel?.checkUserAnswer(userAnswer: userAnswerText))! {
                delegate?.rightAnswerReaction()
            } else {
                delegate?.wrongAnswerReaction()
            }
        }
    }
    
    @objc func bgButtonTapped(sender: UIButton) {
        self.endEditing(true)
    }
}

extension QuizWriteNoteCollectionViewCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= numberOfLettersInTextField
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        textField.resignFirstResponder()
        return true
    }
}
// MARK: UITextFieldDelegate <---
