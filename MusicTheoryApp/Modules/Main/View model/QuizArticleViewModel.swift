//
//  QuizArticleViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.12.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class QuizArticleViewModel {
    var model: QuizArticle
    var imageName: String
    var previousPercent: CGFloat = 0.0
   
    var previousPercentInAngle: CGFloat {
        get {
            var angle = (CGFloat(previousPercent)*360)/100
            angle *= CGFloat.pi/180
            angle -= CGFloat.pi/2
            print("previousPercent = \(previousPercent)")
            print("previous angle = \(angle)")
            return angle
        }
    }
    
    var percentIsChanged: Bool {
        get { return self.previousPercent != self.percent}
    }
    
    var percentInAngle: CGFloat {
         get {
            var angle = (CGFloat(percent)*360)/100
            angle *= CGFloat.pi/180
            angle -= CGFloat.pi/2
          //  angle += CGFloat.pi/2 //temp
            print("percent = \(percent)")
            print("angle = \(angle)")
            return angle//(CGFloat(angle) * CGFloat.pi)/180
         }
     }
    
    init(model: QuizArticle, imageName: String) {
        self.model = model
        self.imageName = imageName
        previousPercent = percent
    }
    
    var percent: CGFloat {
        get {
            return CGFloat((model.numberOfFinishedTasks*100)/model.articleQuestions.count)
        }
    }
    
    func articleTitle() -> String {
        return model.article.rawValue
    }
    
    func resultTitle() -> String {
        return "Выполнено \(String(describing: Int(percent)))%"
    }
    
    func afterAnimation() {
        previousPercent = percent
    }
 
    func clearArticleResult() {
        model.clearFinichedTasks()
        previousPercent = percent
    }
}
