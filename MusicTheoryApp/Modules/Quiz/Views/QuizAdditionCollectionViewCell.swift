//
//  QuizAdditionCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static let QUESTION_FONT: UIFont = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
            return UIFont.boldSystemFont(ofSize: 23.0)
        }
        return UIFont.boldSystemFont(ofSize: 20.0)
    }()
    
    let LEFT_OFFSET: CGFloat = 15.0
    let TOP_OFFSET: CGFloat = 15.0
    var numberOfTaskElements = 0
    
    lazy var collectoinViewHight: CGFloat = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 200.0
        }
        return 150.0
    }()
    
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
    
    //MARK: -ViewModel
    var viewModel: MusicTaskAdditionViewModel!
    
    //MARK: -Init
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Public methods
    func configureSubviews(viewModel: MusicTaskAdditionViewModel, frame: CGRect) {
        self.viewModel = viewModel
        contentView.backgroundColor = .cyan
        //question
        questionLabel.text = viewModel.model.questionText
        self.contentView.addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 2*LEFT_OFFSET).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizPauseAndDurationCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        let taskCollectionViewWidth = 2*(frame.size.width - 2*LEFT_OFFSET)/3
        
        if let notesVariables = viewModel.notesVariables {
            numberOfTaskElements = notesVariables.count * 2 + 1 //1 для ячейки со знаком ?
        }
        
        if let pausesVariables = viewModel.pausesVariables {
            numberOfTaskElements = pausesVariables.count * 2 + 1//1 для ячейки со знаком ?
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0.0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        var itemWidth:CGFloat = (numberOfTaskElements > 1) ? ((taskCollectionViewWidth - CGFloat(numberOfTaskElements-1)*5.0)/CGFloat(numberOfTaskElements)) : 30.0
        layout.itemSize = CGSize(
            width: itemWidth,
            height: collectoinViewHight)
        
        let taskCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        taskCollectionView.isScrollEnabled = false
        taskCollectionView.dataSource = self
        // variantsCollectionView.delegate = self
        taskCollectionView.backgroundColor = .white
        taskCollectionView.register(QuizAdditionNotesCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionNotesCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizAdditionPausesCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionPausesCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizAdditionSignsCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizVariantCollectionViewCell.self, forCellWithReuseIdentifier: QuizVariantCollectionViewCell.cellIdentifier)
        
        self.contentView.addSubview(taskCollectionView)
        taskCollectionView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        taskCollectionView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        taskCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(collectoinViewHight)).isActive = true
        taskCollectionView.widthAnchor.constraint(equalToConstant: taskCollectionViewWidth).isActive = true
    }
}

extension QuizAdditionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfTaskElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row != (numberOfTaskElements - 1) {
            let elemtIndex = elementIndex(index: indexPath.row)

            if let notesVars = viewModel.notesVariables {
                //вернуть ячейку для ноты/знака
                let noteAndSign = notesVars[elemtIndex.0]
                if elemtIndex.1 == 0 {//ячейка для ноты
                    let noteViewModel = noteAndSign.0
                    var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionNotesCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionNotesCollectionViewCell
                    if cell == nil {
                        cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionNotesCollectionViewCell
                    }
                    cell!.configureSubviews(viewModel: noteViewModel)
                    return cell!
                } else {//ячейка для знака
                    let signViewModel = noteAndSign.1
                    var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionSignsCollectionViewCell
                          if cell == nil {
                              cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionSignsCollectionViewCell
                          }
                          cell!.configureSubviews(model: signViewModel)
                          return cell!
                }
            }
            if let puseVars = viewModel.pausesVariables {
                //вернуть ячейку для паузы/знака
                let pauseAndSign = puseVars[elemtIndex.0]
                if elemtIndex.1 == 0 {//ячейка для паузы
                    let pauseViewModel = pauseAndSign.0
                    var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionPausesCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionPausesCollectionViewCell
                    if cell == nil {
                        cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionPausesCollectionViewCell
                    }
                    cell!.configureSubviews(viewModel: pauseViewModel)
                    return cell!
                } else {//ячейка для знака
                    let signViewModel = pauseAndSign.1
                    var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionSignsCollectionViewCell
                          if cell == nil {
                              cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionSignsCollectionViewCell
                          }
                          cell!.configureSubviews(model: signViewModel)
                          return cell!
                }
            }
        }
            let signViewModel: MathSigns  = .equation
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionSignsCollectionViewCell
                  if cell == nil {
                      cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionSignsCollectionViewCell
                  }
                  cell!.configureSubviews(model: signViewModel)
                  return cell!
    
        
//        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizVariantCollectionViewCell.cellIdentifier, for: indexPath) as! QuizVariantCollectionViewCell
//        if cell == nil {
//            cell = collectionView.cellForItem(at: indexPath) as! QuizVariantCollectionViewCell
//        }
//        cell.backgroundColor = .red
//        return cell
    }
    
    func elementIndex(index: Int) -> (tupleIndex: Int, indexInTuple: Int) {
        return (index/2, index%2)
    }
    
    
}
