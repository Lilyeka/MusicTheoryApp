//
//  MathSignViewModel.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 15.10.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MathSignViewModel: MathElementViewModel {
    var model: MathSign
    
    var signText: String {
        get {
            switch model.sign {
            case .addition:
                return "+"
            case .subtraction:
                return "-"
            case .equation:
                return "="
            case .question:
                return "?"
            }
        }
    }
    
    var signFontColor: UIColor {
        return model.sign == .question ?  UIColor.gray : UIColor.black
    }
    
    
    
    init(model: MathSign) {
        self.model = model
    }
    
}
