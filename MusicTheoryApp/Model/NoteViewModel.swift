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
    var needsAdditionalLine:Bool {
        get {
            switch self.model.name {
                case .Do,.la1:
                    return true
                default:
                    return false
            }
        }
    }
    
    init(model:Note) {
        self.model = model
    }
}

extension NoteViewModel {
    // Функция возвращает названия картинок значка и ноты,
    // из высоту, ширину и позицию центра картинки (если не целая нота и/или не диез то центр смещен от реального центра) по Y
    // высота ноты/значка подобрана так,чтобы круглешок ноты был равен расстоянию между линейками)
    func noteImagesHeightsAndCentersPositions(verticalOffset:CGFloat, lineOffset:CGFloat) -> (tone:String?, toneHeight:CGFloat?, toneWidth: CGFloat?, toneY:CGFloat?, duration:String?, durationHeight:CGFloat?,
        durationWidth: CGFloat?, durationY:CGFloat?) {
        var toneImageName: String?
        var durationImageName: String?
        var toneHeight: CGFloat? = nil
        var durationHeight: CGFloat? = nil
        var toneWidth: CGFloat? = nil
        var durationWidth: CGFloat? = nil
        var toneY: CGFloat? = nil
        var durationY: CGFloat? = nil
        var offsetFromToneCenter: CGFloat = 0.0
        var offsetFromDurationCenter: CGFloat = 0.0
        
        let offsetLinePositions = (CGFloat(model.name.rawValue)/2.0)*lineOffset
        switch model.tone {
        case .dies:
            toneImageName = "dies_new"
            toneHeight = 74.0
            toneWidth = 45.0
        case .bimol:
            toneImageName = "bemol"
            toneHeight = 68.0
            toneWidth = 38.0
            offsetFromToneCenter = (toneHeight!/4)-3// + toneHeight!/8)
        default:
            toneImageName = nil
        }
        
        switch model.duration {
        case .whole:
            durationImageName = "whole_note"
            durationHeight = 52.0
            durationWidth = 50.0
        case .half:
            durationImageName = "half_note"
            durationHeight = 109.0
            durationWidth = 60.0
            offsetFromDurationCenter = durationHeight!/4 + durationHeight!/8 - 1
        case .quarter:
            durationImageName = "quarter_note"
            durationHeight = 109.0
            durationWidth = 60.0
            offsetFromDurationCenter = durationHeight!/4 + durationHeight!/8 - 1
        case .eighth:
            durationImageName = "eighth_note"
            durationHeight = 109.0
            durationWidth = 60.0
            offsetFromDurationCenter = durationHeight!/4 + durationHeight!/8
        default:
            durationImageName = nil
        }
    
        if model.tone != .none { toneY = -verticalOffset - offsetLinePositions - offsetFromToneCenter}
        if model.duration != .none { durationY = -verticalOffset - offsetLinePositions - offsetFromDurationCenter }
                
        return (tone:toneImageName, toneWidth:toneWidth, toneHeight:toneHeight, toneY:toneY, duration: durationImageName, durationWidth:durationWidth, durationHeight:durationHeight, durationY:durationY)
    }
    
//    func noteYPositions(verticalOffset:CGFloat, lineOffset:CGFloat) -> (toneY:CGFloat?, durationY:CGFloat?) {
//        var toneY: CGFloat? = nil
//        var durationY: CGFloat? = nil
//        var offsetFromNoteCenter: CGFloat = 0.0
//
//        let offsetLinePositions = (CGFloat(model.name.rawValue)/2.0)*lineOffset
//        if ((model.duration != .whole) || (model.tone != .dies)) {
//            offsetFromNoteCenter = noteHeight/4 + noteHeight/8
//        }
//
//        if model.tone != .none { toneY = -verticalOffset - offsetLinePositions - offsetFromNoteCenter}
//        if model.duration != .none { durationY = -verticalOffset - offsetLinePositions - offsetFromNoteCenter }
//
//        return (toneY:toneY, durationY:durationY)
//    }
}
