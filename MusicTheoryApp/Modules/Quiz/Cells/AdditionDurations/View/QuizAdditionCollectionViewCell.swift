//
//  QuizAdditionCollectionViewCell.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizAdditionCollectionViewCell: UICollectionViewCell {
    
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
    var pickeViewIsShown: Bool = false
    var taskCollectionViewWidth: CGFloat = 0.0
    var pickerViewWidth: CGFloat = 0.0
    
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
 
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CELLS_OFFSET
        layout.minimumLineSpacing = CELLS_OFFSET
        
        let collectoinViewHeight: CGFloat = 150.0
        let itemWidth: CGFloat = 65.0
        self.taskCollectionViewWidth = CGFloat(self.mathElements.count) * itemWidth
        layout.itemSize = CGSize( width: itemWidth, height: collectoinViewHeight)
        
        taskCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        taskCollectionView.isScrollEnabled = false
        taskCollectionView.dataSource = self
        taskCollectionView.delegate = self
        taskCollectionView.backgroundColor = .white
        taskCollectionView.register(QuizAdditionNotesCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionNotesCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizAdditionPausesCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionPausesCollectionViewCell.cellIdentifier)
        taskCollectionView.register(QuizAdditionSignsCollectionViewCell.self, forCellWithReuseIdentifier: QuizAdditionSignsCollectionViewCell.cellIdentifier)
        
        self.contentView.addSubview(taskCollectionView)
        NSLayoutConstraint.activate([
            self.taskCollectionView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -20.0),
            self.taskCollectionView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.taskCollectionView.widthAnchor.constraint(equalToConstant: self.taskCollectionViewWidth),
            self.taskCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(collectoinViewHeight))
        ])
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
        
        self.pickerViewWidth = 2*(frame.size.width - 2*LEFT_OFFSET)/3
        self.pickerView.frame = CGRect(
            x:(self.contentView.frame.width - self.pickerViewWidth)/2,
            y: self.contentView.frame.height - self.contentView.frame.height/3,
            width: self.contentView.frame.height/3,
            height: self.pickerViewWidth)
        self.contentView.addSubview(self.pickerView)
        self.pickerView.transform = CGAffineTransform(rotationAngle: 3.14159/2)
        
        var frameForChange = self.pickerView.frame
        frameForChange.origin.x = (self.contentView.frame.width - self.pickerViewWidth)/2
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
        
        self.questionLabel.text = viewModel.getQuestionText()
        self.contentView.addSubview(self.questionLabel)
        NSLayoutConstraint.activate([
            self.questionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0),
            self.questionLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    //MARK: - Actions
    @objc func onDoneButtonTapped() {
        self.hidePickerViewAndIncreaseTaskCollectionView()
        self.hideBgButton()
        let selectedDuration = self.getSelectedDurationAndRedrawCollectionView()
        self.checkUserAnswer(duration: selectedDuration)
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

//MARK: - UICollectionViewDataSource
extension QuizAdditionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mathElements.count
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
}

//MARK: - UICollectionViewDelegate
extension QuizAdditionCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        if indexPath.row == (self.mathElements.count - 1) {
            showPickerView()
            showBgButton()
        }
    }

//MARK: - Private methods
    fileprivate func showBgButton() {
        self.bgButton.frame = CGRect(
            x: self.contentView.frame.origin.x,
            y: self.contentView.frame.origin.y,
            width: self.contentView.frame.width,
            height: self.contentView.frame.height)
    }
    
    fileprivate func hideBgButton() {
        self.bgButton.frame = CGRect(
            x: self.contentView.frame.origin.x,
            y: self.contentView.frame.origin.y + self.contentView.frame.width,
            width: self.contentView.frame.width,
            height: self.contentView.frame.height)
    }
    
    fileprivate func showPickerView() {
        if !pickeViewIsShown {
            UIView.animate(withDuration: 0.3) {
                var frameForChange = self.pickerView.frame
                frameForChange.origin.x = (self.contentView.bounds.width - self.pickerViewWidth)/2
                frameForChange.origin.y = self.contentView.bounds.height - self.contentView.bounds.height/3
                self.pickerView.frame = frameForChange
                
                self.pickerToolBar.frame = CGRect(
                    x: self.pickerView.frame.origin.x,
                    y: self.pickerView.frame.origin.y - self.pickerToolBarHeight,
                    width: self.pickerView.frame.size.width,
                    height: self.pickerToolBarHeight)
                
                self.squeeseTaskCollectionView()
            }
            self.pickeViewIsShown = true
        }
    }
    
    fileprivate func squeeseTaskCollectionView() {
        let translate = CATransform3DMakeTranslation(0, -25, 0)
        let scale = CATransform3DScale(translate, 0.8, 0.8, 1)
        self.taskCollectionView.layer.transform = CATransform3DConcat(translate, scale)
    }

    fileprivate func hidePickerViewAndIncreaseTaskCollectionView() {
        if self.pickeViewIsShown {
            var newPickerViewFrame = self.pickerView.frame
            newPickerViewFrame.origin.x = (self.contentView.frame.width - self.pickerViewWidth)/2
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
            self.pickeViewIsShown.toggle()
        }
    }
    
    fileprivate func getSelectedDurationAndRedrawCollectionView() -> Duration {
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
    
    fileprivate func checkUserAnswer(duration: Duration) {
        var cell: QuizAdditionSignsCollectionViewCell?
        if self.mathElements.count > 2 {
            cell = taskCollectionView.cellForItem(at: IndexPath(row: self.mathElements.count - 2, section: 0)) as? QuizAdditionSignsCollectionViewCell
        }
        
        guard let cell = cell else { return }
        self.checkAndReactInView(duration: duration, view: cell.viewForFireworks)
    }
    
    fileprivate func checkAndReactInView(duration: Duration, view: UIView) {
        if viewModel.checkUserAnswer(userAnswer: duration) {
            self.delegate?.additionalRightAnswerReaction(view: view)
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.delegate?.rightAnswerReaction()
            }
        }
    }
}

//MARK: - UIPickerViewDataSource
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

//MARK: - UIPickerViewDelegate
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
        imageView.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
}
