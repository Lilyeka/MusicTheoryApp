//
//  PauseViewModelSeparate.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 12.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class PauseViewModelSeparate:MathElementViewModel {
    var model: Pause
    
    var duration: Duration {
        get { return model.duration }
    }
    
    var imageName: String {
        get {
            switch model.duration {
            case .half:
                return "half_rest_separate"
            case .quarter:
                return "quarter_rest"
            case .eighth:
                return "eight_rest"
            case .sixteen:
                return "sixteen_rest"
            default:
                return "whole_rest_separate"
            }
        }
    }
    
    var height: CGFloat {
        get {
            switch model.duration {
            case .sixteen:
                return sixteenRestSize().height
            case .eighth :
                return eightRestSize().height
            case .quarter:
                return quarterRestSize().height
            case .half:
                return halfRestSize().height
            case .whole:
                return wholeRestSize().height
            default:
                return  109.0
            }
        }
    }
    
    var width: CGFloat {
        get {
            switch model.duration {
            case .sixteen:
                return sixteenRestSize().width
            case .eighth:
                return eightRestSize().width
            case .quarter:
                return quarterRestSize().width
            case .half:
                return halfRestSize().width
            case .whole:
                return wholeRestSize().width
            default:
                return 60.0
            }
        }
    }
    
    var innerOffsetFromCenter: CGFloat {
        get {
            switch model.duration {
            case .sixteen:
                return sixteenRestSize().offsetFromCenter
            case .eighth:
                return eightRestSize().offsetFromCenter
            case .quarter:
                return quarterRestSize().offsetFromCenter
            case .half:
                return halfRestSize().offsetFromCenter
            case .whole:
                return wholeRestSize().offsetFromCenter
            default:
                return 0.0
            }
        }
    }
    
    init(model: Pause) {
        self.model = model
    }
    
    func sixteenRestSize() -> (height: CGFloat, width: CGFloat, offsetFromCenter: CGFloat){
        var height: CGFloat = 90.0
        var width: CGFloat = 37.0
        var offsetFromCenter: CGFloat = 0.0
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            height = 90.0
            width = 37.0
            offsetFromCenter = -14
        } else if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            height = 90.0
            width = 44.0
            offsetFromCenter = -18
        } else if DeviceType.IS_IPHONE_11Pro_X_Xs {
            height = 93.0
            width = 48.0
            offsetFromCenter = -18
        } else if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax ||
            DeviceType.IS_IPHONE_12_12Pro_13_13Pro ||
            DeviceType.IS_IPHONE_12ProMax_13ProMax {
            height = 68.0
            width = 29.0
        }
        return (height: height, width: width, offsetFromCenter:offsetFromCenter)
    }
    
    func eightRestSize() -> (height: CGFloat, width: CGFloat, offsetFromCenter: CGFloat){
        var height: CGFloat = 68.0
        var width: CGFloat = 24.0
        var offsetFromCenter: CGFloat = 0.0
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            height = 68.0
            width = 24.0
        } else if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            height = 68.0
            width = 28.0
        } else if DeviceType.IS_IPHONE_11Pro_X_Xs {
            height = 68.0
            width = 29.0
        } else if (DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_12_12Pro_13_13Pro) ||
            DeviceType.IS_IPHONE_12ProMax_13ProMax {
            height = 68.0
            width = 29.0
        }
        return (height: height, width: width, offsetFromCenter:offsetFromCenter)
    }
    
    func quarterRestSize() -> (height: CGFloat, width: CGFloat, offsetFromCenter: CGFloat) {
        var height: CGFloat = 83.0
        var width: CGFloat = 37.0
        var offsetFromCenter: CGFloat = 0.0
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            height = 83.0
            width = 37.0
            offsetFromCenter = -3.0
        } else if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            height = 86.0
            width = 40.0
            offsetFromCenter = -3.0
        } else if DeviceType.IS_IPHONE_11Pro_X_Xs {
            height = 93.0
            width = 40.0
            offsetFromCenter = -4.0
        } else if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax ||
            DeviceType.IS_IPHONE_12_12Pro_13_13Pro ||
            DeviceType.IS_IPHONE_12ProMax_13ProMax {
             height = 93.0
             width = 40.0
             offsetFromCenter = -4.0
        }
        return (height: height, width: width, offsetFromCenter:offsetFromCenter)
    }
    
    func halfRestSize() -> (height: CGFloat,width: CGFloat, offsetFromCenter: CGFloat) {
        var height: CGFloat = 45.0
          var width: CGFloat = 45.0
          var offsetFromCenter: CGFloat = 0.0
          if DeviceType.IS_IPHONE_6_6s_7_8 {
              height = 45.0
              width = 45.0
              offsetFromCenter = 23.0
          } else if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
              height = 49.0
              width = 49.0
              offsetFromCenter = 26.0
          } else if DeviceType.IS_IPHONE_11Pro_X_Xs {
              height = 50.0
              width = 50.0
              offsetFromCenter = 27.0
          } else if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax || DeviceType.IS_IPHONE_12_12Pro_13_13Pro ||
              DeviceType.IS_IPHONE_12ProMax_13ProMax {
              height = 50.0
              width = 50.0
              offsetFromCenter = 27.0
          }
          return (height: height, width: width, offsetFromCenter: offsetFromCenter)
    }
    
    func wholeRestSize() -> (height: CGFloat,width: CGFloat, offsetFromCenter: CGFloat) {
        var height: CGFloat = 45.0
        var width: CGFloat = 45.0
        var offsetFromCenter: CGFloat = 0.0
        if DeviceType.IS_IPHONE_6_6s_7_8 {
            height = 45.0
            width = 45.0
            offsetFromCenter = -10.0
        } else if DeviceType.IS_IPHONE_6P_6sP_7P_8P_ {
            height = 49.0
            width = 49.0
            offsetFromCenter = -10.0
        } else if DeviceType.IS_IPHONE_11Pro_X_Xs {
            height = 50.0
            width = 50.0
            offsetFromCenter = -10.0
        } else if DeviceType.IS_IPHONE_11_XR_11PMax_XsMax ||
            DeviceType.IS_IPHONE_12_12Pro_13_13Pro ||
            DeviceType.IS_IPHONE_12ProMax_13ProMax {
            height = 50.0
            width = 50.0
            offsetFromCenter = -12.0
        }
        return (height: height, width: width, offsetFromCenter: offsetFromCenter)
    }
}
