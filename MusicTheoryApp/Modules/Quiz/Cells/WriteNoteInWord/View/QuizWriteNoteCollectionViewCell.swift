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
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_12ProMax_13ProMax {
            return UIFont.boldSystemFont(ofSize: 45.0)
        }
        return UIFont.boldSystemFont(ofSize: 35.0)
    }()
           
    //MARK: -Delegate
    var delegate: QuizSelectAnswerDelegate?
    
   //MARK: -View Model
    var viewModel: MusicTaskWriteNoteInWordViewModel!
    
    //MARK: -Views
    var staffView: StaffView!
    var wordStackView: UIStackView!
    var textField: UITextField!
    var bgButton: UIButton!
    var questionLabel: UILabel!
    
    //MARK: -Variables
    var numberOfLettersInTextField = 0
    var textFieldPosition = 0
    var letterWidth: CGFloat = { //берем ширину самой широкой буквы
        return "Ж".width(withConstrainedHeight: 50.0,
                         font: QuizWriteNoteCollectionViewCell.WORD_FONT)
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
        
        self.textField = UITextField()
        self.textField.backgroundColor = .clear
        self.textField.textColor = .black
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.textAlignment = .center
        self.textField.placeholder = "?"
        self.textField.font = QuizWriteNoteCollectionViewCell.WORD_FONT
        self.textField.borderStyle = UITextField.BorderStyle.roundedRect
        let traitCollection = self.contentView.traitCollection
        let resolvedColor = UIColor.darkGray/*label*/.resolvedColor(with: traitCollection)
        self.textField.layer.borderColor = resolvedColor.cgColor

       // self.textField.layer.borderColor = UIColor(named: "textFieldColor")?.resolvedColor(with: self.traitCollection).cgColor
        self.textField.autocorrectionType = UITextAutocorrectionType.no
        self.textField.keyboardType = .default
        self.textField.delegate = self
        self.textField.returnKeyType = UIReturnKeyType.done
        self.textField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        self.textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        
        self.bgButton = UIButton()
        self.bgButton.translatesAutoresizingMaskIntoConstraints = false
        self.bgButton.backgroundColor = .clear
        
        self.questionLabel = UILabel()
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.questionLabel.textColor = .black
        self.questionLabel.font = QuizWriteNoteCollectionViewCell.QUESTION_FONT
        self.questionLabel.lineBreakMode = .byWordWrapping
        self.questionLabel.numberOfLines = 0
        self.questionLabel.textAlignment = .center
        self.questionLabel.text = self.viewModel.model.questionText
     
        self.contentView.addSubview(bgButton)
        self.bgButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.bgButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.bgButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.bgButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.bgButton.addTarget(self, action: #selector(bgButtonTapped(sender:)), for: .touchUpInside)
        
        self.contentView.addSubview(questionLabel)
        self.questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        self.questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15.0).isActive = true
        self.questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 30.0).isActive = true
        self.questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizWriteNoteCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        self.staffView = StaffView(
            notesViewModels: self.viewModel.notesViewModels,
            selectOnlyOneNote: true,
            frame: CGRect.zero,
            notesDelegate: nil,
            cleff: self.viewModel.model.cleffType)
        self.staffView.translatesAutoresizingMaskIntoConstraints = false
        self.staffView.isUserInteractionEnabled = false
        
        let halfWidth = (self.contentView.frame.width - 15.0*3)/2
        self.contentView.addSubview(self.staffView)
        self.staffView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.staffView.widthAnchor.constraint(equalToConstant: halfWidth).isActive = true
        self.staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15.0).isActive = true
        self.staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        self.staffView.drawNotesOneByOne1(notesAreTransparent: false, viewWidth: halfWidth)
        
        self.wordStackView = UIStackView()
        self.wordStackView.addBackground(color: .white)
        self.wordStackView.translatesAutoresizingMaskIntoConstraints = false
        self.wordStackView.axis = .horizontal
        self.wordStackView.distribution = .fill
        self.wordStackView.spacing = 5.0
        self.wordStackView.alignment = .center
        
        var i = 0
        for partOfWord in self.viewModel.model.partsOfWord {
            if let note = partOfWord.1 {
                self.numberOfLettersInTextField = note.name.noteRusName().count
                let textWidth = CGFloat(numberOfLettersInTextField) * self.letterWidth + 15.0
                self.textField.widthAnchor.constraint(equalToConstant: textWidth).isActive = true
                self.textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                self.wordStackView.addArrangedSubview(textField)
                self.textFieldPosition = i
            } else {
                let label = UILabel()
                label.text = partOfWord.0
                label.textColor = .black
                label.font = QuizWriteNoteCollectionViewCell.WORD_FONT
                label.textAlignment = i == 0 ? .right : .left
                self.wordStackView.addArrangedSubview(label)
            }
            i += 1
        }
   
        self.contentView.addSubview(self.wordStackView)
        self.wordStackView.backgroundColor = .black
        self.wordStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.wordStackView.centerXAnchor.constraint(equalTo: self.staffView.centerXAnchor, constant: 15.0 + halfWidth).isActive = true
        
        self.questionLabel.superview?.bringSubviewToFront(questionLabel)
    }

    override func prepareForReuse() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        self.viewModel = nil
        self.staffView = nil
        self.wordStackView = nil
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
        self.staffView.layer.transform = CATransform3DConcat(translate, scale)
        
        let translate1 = CATransform3DMakeTranslation(0, -65, 0)
        self.wordStackView.layer.transform = translate1
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
            self.checkAnswer(answerString:text, textField: textField)
        }
        return true
    }
    
    //MARK: - Private methods
    fileprivate func checkAnswer(answerString: String, textField: UITextField) {
        if self.viewModel.checkUserAnswer(userAnswer: answerString) {
            self.delegate?.additionalRightAnswerReaction(view: self.textField)
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.delegate?.rightAnswerReaction()
            }
            self.configurationForRightAnswer()
        } else {
            self.delegate?.wrongAnswerReaction()
        }
    }
    
    fileprivate func configurationForRightAnswer() {
        self.textField.borderStyle = .none
        let text = textConfiguration(text:String(textField.text!))
        self.textField.text = text
        let minTextFieldWidth = text.width(withConstrainedHeight: 50.0, font: QuizWriteNoteCollectionViewCell.WORD_FONT)
        self.wordStackView.spacing = 0.0
        self.textField.widthAnchor.constraint(equalToConstant: minTextFieldWidth).isActive = true
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

