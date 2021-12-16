//
//  QuizWriteNoteCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 14.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizWriteNoteCollectionViewCell: UICollectionViewCell {
    //MARK: -Static

    static let WORD_FONT: UIFont = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            return UIFont.boldSystemFont(ofSize: 45.0)
        }
        return UIFont.boldSystemFont(ofSize: 35.0)
    }()
       
    var numberOfLettersInTextField = 0
    var textFieldPosition = 0
    var letterWidth: CGFloat = { //берем ширину самой широкой буквы
        return "Ж".width(withConstrainedHeight: 50.0, font: QuizWriteNoteCollectionViewCell.WORD_FONT)
    }()
    
    //MARK: -Delegate
    var delegate: QuizSelectAnswerDelegate?
    
   //MARK: -View Model
    var viewModel: MusicTaskWriteNoteInWordViewModel!
    
    //MARK: -Views
    var staffView: StaffView!
    var wordStackView: UIStackView!
    var textField: UITextField!
    
    var bgButton: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = QuizWriteNoteCollectionViewCell.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    //MARK: -Init
    init(frame:CGRect, viewModel:MusicTaskWriteNoteInWordViewModel) {
        super.init(frame: frame)
        self.viewModel = viewModel
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func configureSubviews(viewModel:MusicTaskWriteNoteInWordViewModel, frame:CGRect) {
        self.viewModel = viewModel
        
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.placeholder = "?"
        textField.font = QuizWriteNoteCollectionViewCell.WORD_FONT
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.alphabet
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        

        self.contentView.addSubview(bgButton)
        bgButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        bgButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        bgButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        bgButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        bgButton.addTarget(self, action: #selector(bgButtonTapped(sender:)), for: .touchUpInside)
        
        self.contentView.addSubview(questionLabel)
        questionLabel.text = viewModel.model.questionText
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15.0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 30.0).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizWriteNoteCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        let halfWidth = (self.contentView.frame.width - 15.0*3)/2
        staffView = StaffView(notesViewModels: viewModel.notesViewModels,
                              selectOnlyOneNote: true,
                              frame: CGRect.zero,
                              notesDelegate: nil,
                              cleff: viewModel.model.cleffType)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        
        self.contentView.addSubview(staffView)
        staffView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -0).isActive = true
        staffView.widthAnchor.constraint(equalToConstant: halfWidth).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15.0).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawNotesOneByOne1(notesAreTransparent: false, viewWidth: halfWidth)
        
        wordStackView = UIStackView()
        wordStackView.addBackground(color: .white)
        wordStackView.translatesAutoresizingMaskIntoConstraints = false
        wordStackView.axis = .horizontal
        wordStackView.distribution = .fill
        wordStackView.spacing = 5.0
        wordStackView.alignment = .center
        
        var i = 0
        while i < viewModel.model.partsOfWord!.count {
            if let note = viewModel.model.partsOfWord![i].1 {
                numberOfLettersInTextField = note.name.noteRusName().count
                let textWidth = CGFloat(numberOfLettersInTextField) * letterWidth + 15.0
                textField.keyboardType = .default
                textField.delegate = self
                textField.widthAnchor.constraint(equalToConstant: textWidth).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                wordStackView.addArrangedSubview(textField)
                textFieldPosition = i
            } else {
                let label = UILabel()
                label.text = viewModel.model.partsOfWord![i].0
                label.textColor = .black
                label.font = QuizWriteNoteCollectionViewCell.WORD_FONT
                label.textAlignment = i == 0 ? .right : .left
                wordStackView.addArrangedSubview(label)
            }
            i += 1
        }
   
        self.contentView.addSubview(wordStackView)
        wordStackView.backgroundColor = .black
        wordStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        wordStackView.centerXAnchor.constraint(equalTo: staffView.centerXAnchor, constant: 15.0 + halfWidth).isActive = true
        
        questionLabel.superview?.bringSubviewToFront(questionLabel)
    }
    
    override func prepareForReuse() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        viewModel = nil
        staffView = nil
        wordStackView = nil
    }
    
    override func didMoveToSuperview() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func removeFromSuperview() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Actions    
    @objc func bgButtonTapped(sender: UIButton) {
        self.endEditing(true)
    }
    
    //MARK: - NotificationCenter
    @objc func keyboardWillShow(_ notification: Notification) {
        let translate = CATransform3DMakeTranslation(0, -40, 0)
        let scale = CATransform3DScale(translate, 0.6, 0.6, 1)
        staffView.layer.transform = CATransform3DConcat(translate, scale)
        
        let translate1 = CATransform3DMakeTranslation(0, -65, 0)
        wordStackView.layer.transform = translate1
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        staffView.transform  = CGAffineTransform.identity
        wordStackView.transform  = CGAffineTransform.identity
    }
}

//MARK: - UITextFieldDelegate
extension QuizWriteNoteCollectionViewCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= numberOfLettersInTextField
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        if let text = textField.text, text.count > 0 {
            checkAnswer(answerString:text, textField: textField)
        }
        return true
    }
    //MARK: - Private methods
    fileprivate func checkAnswer(answerString: String, textField: UITextField) {
        if viewModel.checkUserAnswer(userAnswer: answerString) {
            delegate?.additionalRightAnswerReaction(view: textField)
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.delegate?.rightAnswerReaction()
            }
            configurationForRightAnswer()
        } else {
            delegate?.wrongAnswerReaction()
        }
    }
    
    fileprivate func configurationForRightAnswer() {
        textField.borderStyle = .none
        let text = textConfiguration(text:String(textField.text!))
        textField.text = text
        let minTextFieldWidth = text.width(withConstrainedHeight: 50.0, font: QuizWriteNoteCollectionViewCell.WORD_FONT)
        wordStackView.spacing = 0.0
        textField.widthAnchor.constraint(equalToConstant: minTextFieldWidth).isActive = true
    }
    
    fileprivate func textConfiguration(text: String) -> String {
        var resultString = ""
        if textFieldPosition > 0 {
            resultString = text.lowercased()
        } else {
            resultString = text.capitalizingFirstLetter()
        }
        return resultString
    }
}

