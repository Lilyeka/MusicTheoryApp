//
//  MusicTaskWriteNoteInWordView.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 19.06.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MusicTaskWriteNoteInWordViewDelegate {
    func rightAnswerReaction()
    func wrongAnswerReaction()
}

class MusicTaskWriteNoteInWordView: UIView {
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 18.0)
    static let WORD_FONT = UIFont.boldSystemFont(ofSize: 35.0)
    static let TEXTFIELD_LETTER_WIDTH = 30
    //MARK: -Delegate
    var delegate: MusicTaskWriteNoteInWordViewDelegate?

    //MARK: -UI Elements
    var viewModel: MusicTaskWriteNoteInWordViewModel!
    var staffView: StaffView!
    var wordStackView: UIStackView!
    var partsOfWordViews: [UIView] = [UIView]()
    var numberOfLettersInTextField = 0
    
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
        btn.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
        btn.backgroundColor = .gray
        return btn
    }()
    
     //MARK: -Init
    init(viewModel:MusicTaskWriteNoteInWordViewModel, frame:CGRect) {
        super.init(frame: frame)
        self.viewModel = viewModel
        setupSubviews(withFrame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    //MARK: - Private methods
    fileprivate func setupSubviews(withFrame:CGRect) {
        self.addSubview(questionLabel)
        questionLabel.text = viewModel?.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: withFrame.size.width).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: withFrame.size.width, font:MusicTaskShowNoteOnThePianoView.QUESTION_FONT))!).isActive = true
       
        staffView = StaffView(notesViewModels:viewModel!.notesViewModels,
                              selectOnlyOneNote: true,
                              frame: CGRect.zero, notesDelegate: nil)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        staffView.clipsToBounds = true
        self.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15.0).isActive = true
        staffView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        staffView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne(notesAreTransparent: false)
        
         var i = 0
         while i < viewModel.model.partsOfWord!.count {
             if let note = viewModel.model.partsOfWord![i].1 {
                numberOfLettersInTextField = note.name.noteRusName().count
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
        
         self.addSubview(wordStackView)
         wordStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15.0).isActive = true
         wordStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        self.addSubview(checkResultButton)
        checkResultButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        checkResultButton.topAnchor.constraint(equalTo: staffView.bottomAnchor, constant: 15.0).isActive = true
        checkResultButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        checkResultButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
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
}


// MARK:- ---> UITextFieldDelegate

extension MusicTaskWriteNoteInWordView: UITextFieldDelegate {

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
        // return NO to not change text
//        print("While entering the characters this method gets called")
//        return true
        
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



