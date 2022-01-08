//
//  MusicTasksProtocol.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.12.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MusicTasksProtocol: AnyObject {
    var tasks: [MusicTask] { get set }
}
