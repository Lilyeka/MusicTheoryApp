//
//  QuizAdditionCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionCollectionViewCell: UICollectionViewCell {
    //MARK: -Static
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
    
    //MARK: -Constants
    let pickerToolBarHeight: CGFloat = 50.0
    let CELLS_OFFSET: CGFloat = 0.0
    let LEFT_OFFSET: CGFloat = 15.0
    let TOP_OFFSET: CGFloat = 15.0

    //MARK: -Views
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
    
    var bgButton: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .clear
        return btn
    }()
    
    var taskCollectionView: UICollectionView!
    var pickerView: UIPickerView!
    var pickerToolBar: UIToolbar!
 
    
    //MARK: -Variables
    lazy var collectoinViewHight: CGFloat = {
        //        if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_11Pro_X_Xs {
        //            return 200.0
        //        }
        return 150.0
    }()

    var numberOfTaskElements = 0
    var taskCollectionViewWidth: CGFloat = 0.0
    var pickeViewIsShown: Bool = false
    
    //MARK: -ViewModel
    var viewModel: MusicTaskAdditionViewModel!
    var mathElements: [MathElementViewModel]!
    
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
        self.mathElements = viewModel.mathElements
        
        questionLabel.text = viewModel.getQuestionText()
        self.contentView.addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: LEFT_OFFSET).isActive = true
        questionLabel.widthAnchor.constraint(equalToConstant: frame.size.width - 2*LEFT_OFFSET).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: (questionLabel.text?.height(width: frame.size.width, font:QuizPauseAndDurationCollectionViewCell.QUESTION_FONT))!).isActive = true
        
        taskCollectionViewWidth = 2*(frame.size.width - 2*LEFT_OFFSET)/3
        
        numberOfTaskElements = mathElements.count
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0.0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CELLS_OFFSET
        layout.minimumLineSpacing = CELLS_OFFSET
        let itemWidth:CGFloat = (numberOfTaskElements > 1) ? ((taskCollectionViewWidth - CGFloat(numberOfTaskElements-1)*CELLS_OFFSET)/CGFloat(numberOfTaskElements)) : 30.0
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
        taskCollectionView.widthAnchor.constraint(equalToConstant: taskCollectionViewWidth).isActive = true
        taskCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(collectoinViewHight)).isActive = true
        
        self.contentView.addSubview(bgButton)
        self.bgButton.frame = CGRect(
               x: self.contentView.frame.origin.x,
               y: self.contentView.frame.origin.y + self.contentView.frame.size.height,
               width: self.contentView.frame.width,
               height: self.contentView.frame.height)
        bgButton.addTarget(self, action: #selector(bgButtonTapped(sender:)), for: .touchUpInside)
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.contentMode = .center
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.layer.borderWidth = 1.0
        pickerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        
        self.pickerView.frame = CGRect(
            x:(self.contentView.frame.width - taskCollectionViewWidth)/2,
            y: self.contentView.frame.height - self.contentView.frame.height/3,
            width: self.contentView.frame.height/3,
            height: taskCollectionViewWidth)
        self.contentView.addSubview(self.pickerView)
        self.pickerView.transform = CGAffineTransform(rotationAngle: 3.14159/2)
        
        var frameForChange = self.pickerView.frame
        frameForChange.origin.x = (self.contentView.frame.width - taskCollectionViewWidth)/2
        frameForChange.origin.y = self.contentView.frame.height + self.contentView.frame.height/3 + CGFloat(pickerToolBarHeight)
        self.pickerView.frame = frameForChange
        
        pickerToolBar = UIToolbar()
        pickerToolBar.barStyle = .default
        pickerToolBar.sizeToFit()
        pickerToolBar.clipsToBounds = true
        pickerToolBar.layer.cornerRadius = 10.0
        pickerToolBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .done, target: self, action: #selector(onDoneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(onCancelPickerViewTapped))
        
        pickerToolBar.items = [cancelButton,spaceButton,doneButton]
        
        self.pickerToolBar.frame = CGRect(
            x: self.pickerView.frame.origin.x,
            y: self.pickerView.frame.origin.y - pickerToolBarHeight,
            width: self.pickerView.frame.size.width,
            height: pickerToolBarHeight)
        self.contentView.addSubview(self.pickerToolBar)

    }
    
    //MARK: - Actions
    @objc func onDoneButtonTapped() {
        hidePickerViewAndIncreaseTaskCollectionView()
        hideBgButton()
        let selectedDuration = getSelectedDurationAndRedrawCollectionView()
        checkUserAnswer(duration:selectedDuration)
    }
    
    @objc func onCancelPickerViewTapped() {
        hidePickerViewAndIncreaseTaskCollectionView()
        hideBgButton()
    }
    
    @objc func bgButtonTapped(sender: UIButton) {
        hidePickerViewAndIncreaseTaskCollectionView()
        hideBgButton()
    }
    
    override func prepareForReuse() {
        taskCollectionView.removeFromSuperview()
    }
}

extension QuizAdditionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfTaskElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = mathElements[indexPath.row]
        switch element {
        case is NoteViewModel:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionNotesCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionNotesCollectionViewCell
            if cell == nil {
                cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionNotesCollectionViewCell
            }
            cell!.configureSubviews(viewModel: element as! NoteViewModel)
            return cell!
        case is PauseViewModelSeparate:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionPausesCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionPausesCollectionViewCell
            if cell == nil {
                cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionPausesCollectionViewCell
            }
            cell!.configureSubviews(viewModel: element as! PauseViewModelSeparate)
            return cell!
        case is MathSignViewModel:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionSignsCollectionViewCell
            if cell == nil {
                cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionSignsCollectionViewCell
            }
            cell!.configureSubviews(model: element as! MathSignViewModel)
            return cell!
        default:
            let signViewModel = MathSignViewModel(model: MathSign(sign:.question))
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier, for: indexPath) as? QuizAdditionSignsCollectionViewCell
            if cell == nil {
                cell = collectionView.cellForItem(at: indexPath) as? QuizAdditionSignsCollectionViewCell
            }
            cell!.configureSubviews(model: signViewModel)
            return cell!
        }
    }
    
    func elementIndex(index: Int) -> (tupleIndex: Int, indexInTuple: Int) {
        return (index/2, index%2)
    }
}

extension QuizAdditionCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        if indexPath.row == (numberOfTaskElements - 1) {
            showPickerView()
            showBgButton()
        }
    }
    
    func showBgButton() {
        self.bgButton.frame = CGRect(
            x: self.contentView.frame.origin.x,
            y: self.contentView.frame.origin.y,
            width: self.contentView.frame.width,
            height: self.contentView.frame.height)
    }
    
    func hideBgButton() {
        self.bgButton.frame = CGRect(
            x: self.contentView.frame.origin.x,
            y: self.contentView.frame.origin.y + self.contentView.frame.width,
            width: self.contentView.frame.width,
            height: self.contentView.frame.height)
    }
    
    func showPickerView() {
        if !pickeViewIsShown {
            UIView.animate(withDuration: 0.3) {
                var frameForChange = self.pickerView.frame
                frameForChange.origin.x = (self.contentView.bounds.width - self.taskCollectionView.bounds.size.width)/2
                frameForChange.origin.y = self.contentView.bounds.height - self.contentView.bounds.height/3
                self.pickerView.frame = frameForChange
                
                self.pickerToolBar.frame = CGRect(
                    x: self.pickerView.frame.origin.x,
                    y: self.pickerView.frame.origin.y - self.pickerToolBarHeight,
                    width: self.pickerView.frame.size.width,
                    height: self.pickerToolBarHeight)
                
                self.squeeseTaskCollectionView()
            }
            pickeViewIsShown = true
        }
    }
    
    func squeeseTaskCollectionView() {
        let translate = CATransform3DMakeTranslation(0, -25, 0)
        let scale = CATransform3DScale(translate, 0.8, 0.8, 1)
        self.taskCollectionView.layer.transform = CATransform3DConcat(translate, scale)
    }

    func hidePickerViewAndIncreaseTaskCollectionView() {
        if pickeViewIsShown {
            var newPickerViewFrame = self.pickerView.frame
            newPickerViewFrame.origin.x = (self.contentView.frame.width - self.taskCollectionViewWidth)/2
            newPickerViewFrame.origin.y = self.contentView.frame.height + CGFloat(self.pickerToolBarHeight)
            
            UIView.animate(withDuration: 0.3) {
                self.taskCollectionView.transform = CGAffineTransform.identity
                self.pickerView.frame = newPickerViewFrame
                
                self.pickerToolBar.frame = CGRect(
                    x: self.pickerView.frame.origin.x,
                    y: self.pickerView.frame.origin.y - self.pickerToolBarHeight,
                    width: self.pickerView.frame.size.width,
                    height: self.pickerToolBarHeight)
            }
            pickeViewIsShown = !pickeViewIsShown
        }
    }
    
    func getSelectedDurationAndRedrawCollectionView() -> Duration {
        let index = pickerView.selectedRow(inComponent: 0)
        
        var selectedDuration: Duration = .whole
        if let notesVariants = viewModel.notesVariants {
            selectedDuration = notesVariants[index].duration
            mathElements[mathElements.count - 1] = notesVariants[index]
        }
        if let pausesVariants = viewModel.pausesVariants {
            selectedDuration = pausesVariants[index].duration
            mathElements[mathElements.count - 1] = PauseViewModelSeparate(model: Pause(duration: selectedDuration))
        }
        taskCollectionView.reloadItems(at: [IndexPath(row: mathElements.count - 1, section: 0)])
        return selectedDuration
    }
    
    func checkUserAnswer(duration: Duration) {
        var cell: UICollectionViewCell!
        if viewModel.notesVariants != nil {
             cell = taskCollectionView.cellForItem(at: IndexPath(row: mathElements.count - 1, section: 0)) as! QuizAdditionNotesCollectionViewCell
            checkAndReactInView(duration: duration, view: cell)
        }
        if viewModel.pausesVariants != nil {
             cell = taskCollectionView.cellForItem(at: IndexPath(row: mathElements.count - 1, section: 0)) as! QuizAdditionPausesCollectionViewCell
            checkAndReactInView(duration: duration, view: cell)
        }

    }
    
    func checkAndReactInView(duration: Duration,view: UIView) {
        if viewModel.checkUserAnswer(userAnswer: duration) {
            self.delegate?.additionalRightAnswerReaction(view: view)
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.delegate?.rightAnswerReaction()
            }
        }
    }
}

extension QuizAdditionCollectionViewCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numberOfVariantsElements = 0
        if let notesVariants = viewModel.notesVariants {
            numberOfVariantsElements = notesVariants.count
        }
        if let pausesVariants = viewModel.pausesVariants {
            numberOfVariantsElements = pausesVariants.count
        }
        return numberOfVariantsElements
    }
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
