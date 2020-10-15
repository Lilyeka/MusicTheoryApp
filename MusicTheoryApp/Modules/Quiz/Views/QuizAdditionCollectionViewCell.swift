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
    
    lazy var collectoinViewHight: CGFloat = {
        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
            return 200.0
        }
        return 150.0
    }()
    
    let pickerToolBarHeight = 50
    let CELLS_OFFSET: CGFloat = 0.0
    let LEFT_OFFSET: CGFloat = 15.0
    let TOP_OFFSET: CGFloat = 15.0
    var numberOfTaskElements = 0
    
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
    
    var taskCollectionViewWidth: CGFloat = 0.0
    var taskCollectionView: UICollectionView!
    var pickerView: UIPickerView!
    var pickerToolBar: UIToolbar!
    var pickeViewIsShown: Bool = false
    
    
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
        
        questionLabel.text = viewModel.model.questionText
        self.contentView.addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 2*LEFT_OFFSET).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizPauseAndDurationCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        taskCollectionViewWidth = 2*(frame.size.width - 2*LEFT_OFFSET)/3
        
        if let notesVariables = viewModel.notesVariables {
            numberOfTaskElements = notesVariables.count * 2 + 1
        } else if let pausesVariables = viewModel.pausesVariables {
            numberOfTaskElements = pausesVariables.count * 2 + 1
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0.0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CELLS_OFFSET
        layout.minimumLineSpacing = CELLS_OFFSET
        var itemWidth:CGFloat = (numberOfTaskElements > 1) ? ((taskCollectionViewWidth - CGFloat(numberOfTaskElements-1)*CELLS_OFFSET)/CGFloat(numberOfTaskElements)) : 30.0
        layout.itemSize = CGSize(
            width: itemWidth,
            height: collectoinViewHight)
        
        taskCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        taskCollectionView.isScrollEnabled = false
        taskCollectionView.dataSource = self
        taskCollectionView.delegate = self
        taskCollectionView.backgroundColor = .white
        taskCollectionView.register(QuizAdditionNotesCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionNotesCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizAdditionPausesCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionPausesCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizAdditionSignsCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizVariantCollectionViewCell.self, forCellWithReuseIdentifier: QuizVariantCollectionViewCell.cellIdentifier)
        
        self.contentView.addSubview(taskCollectionView)
        taskCollectionView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -20.0).isActive = true
        taskCollectionView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        taskCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(collectoinViewHight)).isActive = true
        taskCollectionView.widthAnchor.constraint(equalToConstant: taskCollectionViewWidth).isActive = true
        
        pickerView = UIPickerView.init()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.green
        pickerView.contentMode = .center
        pickerView.autoresizingMask = .flexibleWidth
        
        self.pickerView.frame = CGRect(
            x:(self.contentView.frame.width - taskCollectionViewWidth)/2,
            y: self.contentView.frame.height - self.contentView.frame.height/3,
            width: self.contentView.frame.height/3,
            height: taskCollectionViewWidth)
        
        self.contentView.addSubview(self.pickerView)
        self.pickerView.transform = CGAffineTransform(rotationAngle: 3.14159/2)
        
        var frameForChange = self.pickerView.frame
        frameForChange.origin.x = (self.contentView.frame.width - taskCollectionViewWidth)/2
        frameForChange.origin.y = self.contentView.frame.height + CGFloat(pickerToolBarHeight)
        self.pickerView.frame = frameForChange
        
        pickerToolBar = UIToolbar()
        pickerToolBar.barStyle = .default
        pickerToolBar.clipsToBounds = true
        pickerToolBar.layer.cornerRadius = 10.0
        pickerToolBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        pickerToolBar.items = [UIBarButtonItem.init(title: "Выбрать", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        
        self.pickerToolBar.frame = CGRect(
            x: Int(self.pickerView.frame.origin.x),
            y: Int(self.pickerView.frame.origin.y) - 48,
            width: Int(self.pickerView.frame.size.width),
            height: pickerToolBarHeight)
        self.contentView.addSubview(self.pickerToolBar)
    }
}

extension QuizAdditionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        if let notesVariables = viewModel.notesVariables {
        //            return notesVariables.count * 2
        //        } else if let pausesVariables = viewModel.pausesVariables {
        //            return pausesVariables.count * 2
        //        }
        return numberOfTaskElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != (numberOfTaskElements - 1) {
            let elemtIndex = elementIndex(index: indexPath.row)
            if let notesVars = viewModel.notesVariables {//ячейки для ноты/знака
                let noteAndSign = notesVars[elemtIndex.0]
                if elemtIndex.1 == 0 {//ячейка для ноты
                    if let noteViewModel = noteAndSign.0 {
                        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionNotesCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionNotesCollectionViewCell
                        if cell == nil {
                            cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionNotesCollectionViewCell
                        }
                        cell!.configureSubviews(viewModel: noteViewModel)
                        return cell!
                    }
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
            if let pauseVars = viewModel.pausesVariables { //ячейки для паузы/знака
                let pauseAndSign = pauseVars[elemtIndex.0]
                if elemtIndex.1 == 0 {//ячейка для паузы
                    if let pauseViewModel = pauseAndSign.0 {
                        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionPausesCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionPausesCollectionViewCell
                        if cell == nil {
                            cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionPausesCollectionViewCell
                        }
                        cell!.configureSubviews(viewModel: pauseViewModel)
                        return cell!
                    }
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
        let signViewModel = MathSignViewModel(model: MathSign(sign:.question)) 
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionSignsCollectionViewCell
        if cell == nil {
            cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionSignsCollectionViewCell
        }
        cell!.configureSubviews(model: signViewModel)
        return cell!
    }
    
    func elementIndex(index: Int) -> (tupleIndex: Int, indexInTuple: Int) {
        return (index/2, index%2)
    }
}

extension QuizAdditionCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        if indexPath.row == (numberOfTaskElements - 1) && !pickeViewIsShown{
            showPickerView()
        }
    }
    
    @objc func handleGesture(gestureRecognizer:UITapGestureRecognizer) {
        if !pickeViewIsShown {
            showPickerView()
        }
    }
    
    func showPickerView() {
        UIView.animate(withDuration: 0.3) {
            var frameForChange = self.pickerView.frame
            frameForChange.origin.x = (self.contentView.bounds.width - self.taskCollectionView.bounds.size.width)/2
            frameForChange.origin.y = self.contentView.bounds.height - self.contentView.bounds.height/3
            self.pickerView.frame = frameForChange
            
            self.pickerToolBar.frame = CGRect(
                x: Int(self.pickerView.frame.origin.x),
                y: Int(self.pickerView.frame.origin.y) - self.pickerToolBarHeight,
                width: Int(self.pickerView.frame.size.width),
                height: self.pickerToolBarHeight)
            
            let translate = CATransform3DMakeTranslation(0, -20, 0)
            let scale = CATransform3DScale(translate, 0.8, 0.8, 1)
            self.taskCollectionView.layer.transform = CATransform3DConcat(translate, scale)
        }
        pickeViewIsShown = true
    }
    
    @objc func onDoneButtonTapped() {
        pickeViewIsShown = false
        
        var newPickerViewFrame = self.pickerView.frame
        newPickerViewFrame.origin.x = (self.contentView.frame.width - self.taskCollectionViewWidth)/2
        newPickerViewFrame.origin.y = self.contentView.frame.height + CGFloat(self.pickerToolBarHeight)
        
        UIView.animate(withDuration: 0.3) {
            self.taskCollectionView.transform = CGAffineTransform.identity
            self.pickerView.frame = newPickerViewFrame
            
            self.pickerToolBar.frame = CGRect(
                x: Int(self.pickerView.frame.origin.x),
                y: Int(self.pickerView.frame.origin.y) - self.pickerToolBarHeight,
                width: Int(self.pickerView.frame.size.width),
                height: self.pickerToolBarHeight)
        }
        
//        let indexPath = IndexPath(row: numberOfTaskElements - 1, section: 0)
//        var cell = collectionView(taskCollectionView, cellForItemAt: indexPath) as! QuizAdditionSignsCollectionViewCell
//     
//        taskCollectionView.reloadData()
    }
    
}

extension QuizAdditionCollectionViewCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        if let notesArray = viewModel.notesVariants {
        //            return notesArray.count
        //        }
        //        if let pausesArray = viewModel.pausesVariants {
        //            return pausesArray.count
        //        }
        return numberOfTaskElements
    }
    //
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return "www"//pickerData[row]
    //    }
    
    //    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    //        return 200
    //    }
}
extension QuizAdditionCollectionViewCell: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var imageName = ""
        if let notesVariants = viewModel.notesVariants {
            imageName = notesVariants[row].durationImageName
        }
        if let pausesVariants = viewModel.pausesVariants {
            imageName = pausesVariants[row].imageName
        }
        
        let image = UIImage(named:imageName)
        let imageView: UIImageView = UIImageView(image:image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.transform = CGAffineTransform(rotationAngle: 3*3.14159/2)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
}
