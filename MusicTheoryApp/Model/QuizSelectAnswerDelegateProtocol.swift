//
//  QuizSelectAnswerDelegateProtocol.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 30.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol QuizSelectAnswerDelegate: class {
    func rightAnswerReaction()
    func wrongAnswerReaction()
    func additionalRightAnswerReaction(view: UIView)
}
