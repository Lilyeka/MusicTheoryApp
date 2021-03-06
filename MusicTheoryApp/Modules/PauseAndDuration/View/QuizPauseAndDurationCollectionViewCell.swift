//
//  QuizPauseAndDurationCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizPauseAndDurationCollectionViewCell: UICollectionViewCell {
    //MARK: -Static variables
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static let QUESTION_FONT: UIFont = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
            return UIFont.boldSystemFont(ofSize: 23.0)
        }
        return UIFont.boldSystemFont(ofSize: 20.0)
    }()
    
    //MARK: -Delegate
    var delegate: QuizSelectAnswerDelegate?
    
    //MARK: -ViewModel
    var viewModel: MusicTaskPauseAndDurationViewModel!
    
    //MARK: -Constants
    let LEFT_OFFSET: CGFloat = 15.0
    let TOP_OFFSET: CGFloat = 15.0
    
    //MARK: -Variables
    lazy var collectoinViewHight: CGFloat = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 200.0
        }
        return 150.0
    }()
    var previousVariantIndexPath: IndexPath!
    
    //MARK: -Views
    var staffView: StaffView!
    var variantsCollectionView: UICollectionView!
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = QuizPauseAndDurationCollectionViewCell.QUESTION_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
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
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizPauseAndDurationCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        let staffViewWidth = 1*(frame.size.width - 3*LEFT_OFFSET)/3
        let variantsWidth = 2*(frame.size.width - 3*LEFT_OFFSET)/3
        
        staffView = StaffView(cleff: .Treble, frame: frame)
        staffView.translatesAutoresizingMaskIntoConstraints = false
        staffView.isUserInteractionEnabled = false
        self.contentView.addSubview(staffView)
        staffView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: TOP_OFFSET).isActive = true
        staffView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        staffView.widthAnchor.constraint(equalToConstant: staffViewWidth).isActive = true
        staffView.heightAnchor.constraint(equalToConstant: CGFloat(StaffView.viewHeight())).isActive = true
        staffView.drawPause(pause: viewModel.pauseViewModel, viewWidth: staffViewWidth)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0.0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: (variantsWidth - 6*5.0)/5, height: collectoinViewHight)
        
        variantsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        variantsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        variantsCollectionView.isScrollEnabled = false
        variantsCollectionView.dataSource = self
        variantsCollectionView.delegate = self
        variantsCollectionView.backgroundColor = .white
        variantsCollectionView.register(QuizVariantCollectionViewCell.self, forCellWithReuseIdentifier: QuizVariantCollectionViewCell.cellIdentifier)
    
        self.contentView.addSubview(variantsCollectionView)
        variantsCollectionView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0.0).isActive = true
        variantsCollectionView.leftAnchor.constraint(equalTo: staffView.rightAnchor, constant: LEFT_OFFSET).isActive = true
        variantsCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -LEFT_OFFSET).isActive = true
        variantsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(collectoinViewHight)).isActive = true
    }
}

//MARK: -UICollectionViewDataSource
extension QuizPauseAndDurationCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizVariantCollectionViewCell.cellIdentifier, for: indexPath) as? QuizVariantCollectionViewCell
        cell?.configureSubviews(viewModel: viewModel.notesViewModels[indexPath.row])
        return cell!
    }    
}

//MARK: -UICollectionViewDelegate
extension QuizPauseAndDurationCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! QuizVariantCollectionViewCell
        
        let selectedDuration = viewModel.noteDuration(noteIndex: indexPath.row)
        
        if viewModel.checkUserAnswer(answer: selectedDuration) {
            if previousVariantIndexPath != nil {
                let previousCell = collectionView.cellForItem(at: previousVariantIndexPath)
                previousCell?.layer.borderColor = UIColor.gray.cgColor
            }
            cell.layer.borderColor = UIColor.green.cgColor
            self.delegate?.additionalRightAnswerReaction(view: cell.viewForFireworks)
            collectionView.isUserInteractionEnabled = false
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline:.now() + seconds) {
                self.delegate?.rightAnswerReaction()
            }
        } else {
            if previousVariantIndexPath != nil {
                let previousCell = collectionView.cellForItem(at: previousVariantIndexPath)
                previousCell?.layer.borderColor = UIColor.gray.cgColor
            }
            cell.layer.borderColor = UIColor.red.cgColor
        }
        previousVariantIndexPath = indexPath
    }
}



