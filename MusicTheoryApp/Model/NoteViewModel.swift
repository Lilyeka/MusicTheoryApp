//
//  NoteViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

struct NoteViewModel {
    let model: Note
    
    init(model:Note) {
        self.model = model
    }
}

extension NoteViewModel {
    //TODO: cделать функцию notePosition (вынести из StaffView)
    //которая будет выдавать координату Y центра ноты на нотном листе
    //например у всех нот кроме целой и у бимоля координата центра ноты по Y смещена вниз на середину кружочка,
    //а у целой ноты и у диеза координата центра ноты по Y не смещена вниз
    
    //ссылка на картинку
    var imagesForNote: (tone: String?, duration: String?) {
        var toneImageName: String?
        var durationImageName: String?
        
        switch model.tone {
        case .dies:
            toneImageName = "dies_new"
        case .bimol:
            toneImageName = "bimol"
        default:
            toneImageName = nil
        }
        
        switch model.duration {
        case .whole:
            durationImageName = "whole_note"
        case .half:
            durationImageName = "half_note"
        case .quarter:
            durationImageName = "quarter_note"
        case .eighth:
            durationImageName = "eighth_note"
        default:
            durationImageName = nil
        }
        return (tone: toneImageName, duration: durationImageName)
    }
}
