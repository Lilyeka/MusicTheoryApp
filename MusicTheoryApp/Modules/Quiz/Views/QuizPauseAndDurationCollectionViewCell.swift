//
//  QuizPauseAndDurationCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizPauseAndDurationCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    static let QUESTION_FONT = UIFont.boldSystemFont(ofSize: 18.0)
    
    let LEFT_OFFSET: CGFloat = 15.0
    let TOP_OFFSET: CGFloat = 15.0
    //MARK: -Views
    var staffView: StaffView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        label.textColor = .white
        label.font = QuizPauseAndDurationCollectionViewCell.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var tempView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    //MARK: -ViewModel
    var viewModel: MusicTaskPauseAndDurationViewModel!
    
    //MARK: -Init
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Public methods
    func configureSubviews(viewModel: MusicTaskPauseAndDurationViewModel, frame: CGRect) {
        self.viewModel = viewModel
        self.contentView.backgroundColor = .white
        
        questionLabel.text = viewModel.model.questionText
        self.contentView.addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15.0).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 30.0).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizSelectNoteInWordCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        let staffViewWidth = 1*(frame.size.width - 3*LEFT_OFFSET)/3
        let tempViewWidth = 2*(frame.size.width - 3*LEFT_OFFSET)/3
        
        staffView = StaffView(cleff: .Treble, frame: frame)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        self.contentView.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        staffView.widthAnchor.constraint(equalToConstant: staffViewWidth).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawPause(pause: viewModel.pauseViewModel, viewWidth: staffViewWidth)

        self.contentView.addSubview(tempView)
        tempView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        tempView.leftAnchor.constraint(equalTo: staffView.rightAnchor, constant: LEFT_OFFSET).isActive = true
        tempView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -LEFT_OFFSET).isActive = true
        tempView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        
    }
}
