//
//  NoteViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.05.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol NoteViewModelDelegate {
    func noteTaped(noteName:Note.NoteName, noteView: UIView)
}

class NoteViewModel {
    static let TRANSPARENT_ALFA: CGFloat = 0.3
    static let OPAQUE_ALFA: CGFloat = 1.0
    static let NOTE_LABEL_FONT =  UIFont.boldSystemFont(ofSize: 18.0)
    
    var delegate: NoteViewModelDelegate?
    
    let model: Note
    
    var alfa: CGFloat = NoteViewModel.OPAQUE_ALFA
    var selected: Bool = false
    
    var imageView = UIImageView()
        
    func additionalLine(cleff: CleffTypes) -> Bool {
        if cleff == .Treble {
            switch self.model.name {
            case .Do,.la1,.do2,.mi2:
                return true
            default:
                return false
            }
        }
        switch self.model.name {
        case .Do,.mi,.do2,.mi2:
            return true
        default:
            return false
        }
    }

    func underline(cleff: CleffTypes) -> Bool {  //как "подчеркивание"
        if cleff == .Treble {
            return self.model.name == .si1 ? true : false
        }
        return self.model.name == .re2 ? true : false
    }
    
    func upperLine(cleff: CleffTypes) -> Bool {//как "надчеркивание"
        if cleff == .Bass {
            return self.model.name == .re ? true : false
        }
        return false
    }
    
    func topAdditionalLine(cleff: CleffTypes) -> Bool { //как доп. линейка над нотой сверху
        if cleff == .Bass {
            return self.model.name == .Do ? true : false
        }
        return false
    }
    
    init(model:Note) {
        self.model = model
    }
}

extension NoteViewModel {
    // Функция возвращает названия картинок значка и ноты,
    // их высоту, ширину и смещение центра картинки по Y (если не целая нота и/или не диез то центр смещен от реального центра)
    // высота ноты/значка подобрана так,чтобы круглешок ноты был равен расстоянию между линейками)
    func noteImagesHeightsAndCentersPositions() -> (tone:String?, toneHeight:CGFloat?, toneWidth: CGFloat?, toneCenterOffesetY:CGFloat?, duration:String?, durationHeight:CGFloat?,
        durationWidth: CGFloat?, durationCenterOffesetY:CGFloat) {
            var toneImageName: String?
            var durationImageName: String?
            var toneHeight: CGFloat? = nil
            var durationHeight: CGFloat? = nil
            var toneWidth: CGFloat? = nil
            var durationWidth: CGFloat? = nil
            var offsetFromToneCenter: CGFloat = 0.0
            var offsetFromDurationCenter: CGFloat = 0.0
            
            switch model.tone {
            case .dies:
                toneImageName = "dies_new"
                toneHeight = 74.0
                toneWidth = 45.0
            case .bimol:
                toneImageName = "bemol"
                toneHeight = 68.0
                toneWidth = 38.0
                offsetFromToneCenter = (toneHeight!/4)-3.0
            default:
                toneImageName = nil
            }
            
            switch model.duration {
            case .whole:
                durationImageName = "whole_note"
                durationHeight = wholeNoteSize().height
                durationWidth = wholeNoteSize().width
                offsetFromDurationCenter = 1
            // TODO: Для остальных нот тоже устанавливать значения в зависимости от типа девайса
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
            
            return (tone:toneImageName, toneWidth:toneWidth, toneHeight:toneHeight, toneCenterOffesetY:offsetFromToneCenter, duration: durationImageName, durationWidth:durationWidth, durationHeight:durationHeight, durationCenterOffesetY:offsetFromDurationCenter)
    }
    
    func didTapped(noteView: UIView) {
        self.selected = !self.selected
        delegate?.noteTaped(noteName:self.model.name, noteView: noteView)
    }
    
    func noteTitleBottomOffset(cleff: CleffTypes) -> CGFloat {
        switch model.name.rawValue {
        case 0...6:
            return cleff == CleffTypes.Treble ? noteTitleBottomOffsetForTrebleFirstOctave() : noteTitleBottomOffsetForBassBigOctave()
        case 7...13:
            return cleff == CleffTypes.Treble ? noteTitleBottomOffsetForTrebleSecondOctave() :
                noteTitleBottomOffsetForBassSmallOctave()
        default:
            return 0.0
        }
    }
    
    func noteTitleBottomOffsetForBassBigOctave() -> CGFloat {
        return -35.0 // it's good for all device types
    }
    
    func noteTitleBottomOffsetForBassSmallOctave() -> CGFloat {
        return -35.0 // it's good for all device types
    }
    
    fileprivate func noteTitleBottomOffsetForTrebleFirstOctave() -> CGFloat {
        return 0.0 // it's good for all device types
    }
    
    fileprivate func noteTitleBottomOffsetForTrebleSecondOctave() -> CGFloat {
        return -35.0 // it's good for all device types
    }
    
    func wholeNoteSize() -> (height: CGFloat,width: CGFloat) {
        var height: CGFloat = 0.0
        var width: CGFloat = 0.0
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            height = 45.0
            width = 45.0
        } else if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            height = 49.0
            width = 49.0
        } else if DeviceType.IS_IPHONE_11Pro_X_Xs {
            height = 50.0
            width = 50.0
        } else if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax {
            height = 50.0
            width = 50.0
        }
        return (height: height, width: width)
    }
    
}
