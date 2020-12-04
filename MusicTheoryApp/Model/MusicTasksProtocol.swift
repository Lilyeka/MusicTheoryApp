//
//  MusicTasksProtocol.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 04.12.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

protocol MusicTasksProtocol: class {
    var tasks: [MusicTask] { get set }
}

extension MusicTasksProtocol{

var percentOfFinishedTasks: Int {
       get {
           return (tasks.filter({$0.done == true}).count*100)/tasks.count
       }
   }
}
