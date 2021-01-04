//
//  MainInteractor.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 07.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol!
    
    var articles: [QuizArticleViewModel] = [
        QuizArticleViewModel(
            model: QuizArticle(article: .trebleCleffNotes, questions: MusicTasks.shared.tasks),
            imageName: "mainTreble"),
        QuizArticleViewModel(
            model: QuizArticle(article: .bassCleffNotes, questions:MusicTasksBass.shared.tasks),
            imageName: "mainBass"),
        QuizArticleViewModel(
            model: QuizArticle(article: .durationsAndPauses, questions: MusicTasksPausesDurations.shared.tasks),
            imageName: "mainDuration")
        ] 

    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter

    }
}
