//
//  PauseViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class PauseViewModel {
    var model: Pause
    var imageName: String { // TODO: заменить на картинки пауз!!!
        get {
            switch model.duration {
            case .half:
                return "half_note"
            case .quarter:
                return "quarter_note"
            case .eighth:
                return "eighth_note"
            default:
                return "whole_note"
            }
        }
    }
    
    var height: CGFloat {
        get {
            switch model.duration {
            case .whole:
                return wholeNoteSize().height
            default:
                return  109.0
            }
        }
    }
    
    var width: CGFloat {
        get {
            switch model.duration {
            case .whole:
                return wholeNoteSize().width
            default:
                return 60.0
            }
        }
    }
    
    var innerOffsetFromCenter: CGFloat {
        get {
            return 5.0
        }
    }
    
    
    init(model: Pause) {
        self.model = model
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
