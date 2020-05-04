//
//  NoteViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

struct NoteViewModel {
    private let model: Note
    
    init(model:Note) {
        self.model = model
    }
}

extension NoteViewModel {
    //TODO: cделать функцию notePosition (вынести из StaffView)
    //которая будет выдавать координату Y центра ноты на нотном листе
    //например у половиной ноты и у бимоля координата центра ноты по y смещена вниз на середину кружочка
    //а у целой ноты и у диеза координата центра ноты по у не смещена вниз
    
    //ссылка на картинку
    var imageForNote: String {
        switch model.duration {
        case .whole:
            return "whole_note"
        case .half:
            return "half_note"
        default:
            return "whole_note"
        }
    }
    
    var imageForNoteBadge: String {
        switch model.duration {
        case .none:
            if model.tone == .bimol { return "bemol" }
            return "dies_new"
        default:
            return "bemol"
        }
    }
}
