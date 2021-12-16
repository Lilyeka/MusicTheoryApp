//
//  GameInfoViewController.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 11.05.2021.
//  Copyright © 2021 Лилия Левина. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {
    //MARK: -Constants
    let OFFSET: CGFloat = 30.0
    let INNER_OFFSET: CGFloat = 10.0
    let CORNER_RAD: CGFloat = 15.0
    let HEADER_HEIGHT: CGFloat = 44.0
    let IMAGE_IN_TEXTVIEW_SIZE: CGFloat = 28.0
    let FONT: UIFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 16.0)
    let FONT_COLOR: UIColor = #colorLiteral(red: 0.07422413677, green: 0.5216350555, blue: 0.8784367442, alpha: 1)
    
    //MARK: -UI Elements
//    var numberOfLines: Int!
//    var startImage: UIImage!
//    var targetImage: UIImage!
    var tableView: SelfSizedTableView = {
        var tableView = SelfSizedTableView()
        tableView.alwaysBounceVertical = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 15.0
        tableView.register(GameInfoTableViewCell.self, forCellReuseIdentifier: GameInfoTableViewCell.reuseIdentifier)
        tableView.register(GameInfoLinksTableViewCell.self, forCellReuseIdentifier: GameInfoLinksTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        return tableView
    }()
    
    //MARK: -Init
//    init(startImage: UIImage, targetImage: UIImage, numberOfLines: Int) {
//        self.startImage = startImage
//        self.targetImage = targetImage
//        self.numberOfLines = numberOfLines
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.invalidateIntrinsicContentSize()
        tableView.layoutIfNeeded()
    }
    
    //MARK: -Private methods
    fileprivate func configureObjects() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.backgroundViewTapped(sender:)))
        self.view.addGestureRecognizer(tapRecognizer)
        
        let centralView = UIView(frame:.zero)
        centralView.layer.cornerRadius = CORNER_RAD
        centralView.backgroundColor = .white
        self.view.addSubview(centralView)
        centralView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = GameInfoHeaderView(frame: .zero)
        headerView.isUserInteractionEnabled = true
        headerView.layer.cornerRadius = CORNER_RAD
        headerView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        centralView.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: centralView.leftAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: centralView.topAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: centralView.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: HEADER_HEIGHT).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        centralView.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: centralView.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: centralView.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: centralView.bottomAnchor,constant: -INNER_OFFSET).isActive = true
        
        centralView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: OFFSET).isActive = true
        centralView.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -OFFSET).isActive = true
        centralView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        centralView.heightAnchor.constraint(lessThanOrEqualToConstant: self.view.frame.height - 2*OFFSET).isActive = true
    }
    //Mark: - Actions
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer? = nil) {
        let point = sender?.location(in: sender?.view)
        let viewTouched = sender?.view?.hitTest(point!, with: nil)
        if viewTouched == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: -UITableViewDataSource
extension GameInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: GameInfoTableViewCell.reuseIdentifier, for: indexPath) as? GameInfoTableViewCell
            if cell == nil {
                cell = GameInfoTableViewCell()
            }
            cell!.selectionStyle = .none
            cell!.configureTextView()
            return cell!
        } else if indexPath.row == 1 {
            var cell = tableView.dequeueReusableCell(withIdentifier: GameInfoLinksTableViewCell.reuseIdentifier, for: indexPath) as? GameInfoLinksTableViewCell
            if cell == nil {
                cell = GameInfoLinksTableViewCell(style: .default, reuseIdentifier: GameInfoLinksTableViewCell.reuseIdentifier)
            }
            return cell!
        } else {
            let cell = UITableViewCell(frame: .zero)
            return cell
        }
    }
}

//MARK: -UITableViewDelegate
extension GameInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: -GameInfoHeaderViewDelegate
extension GameInfoViewController: GameInfoHeaderViewDelegate {
    func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
