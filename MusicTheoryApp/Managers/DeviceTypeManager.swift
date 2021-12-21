//
//  DeviceTypeManager.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 26.07.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone
    case pad
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_5_SE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_6s_7_8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_6sP_7P_8P_ = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_11Pro_X_Xs = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_11_XR_11PMax_XsMax = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPHONE_12_12Pro_13_13Pro = UIDevice.current.userInterfaceIdiom == .phone &&  ScreenSize.SCREEN_MAX_LENGTH == 844.0
    static let IS_IPHONE_12ProMax_13ProMax = UIDevice.current.userInterfaceIdiom == .phone &&  ScreenSize.SCREEN_MAX_LENGTH == 926.0
}

