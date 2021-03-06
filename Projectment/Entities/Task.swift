//
//  Task.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import Unrealm

struct Task: Realmable, Entitiable {
  var id              : String = UUID().uuidString
  var title           : String = "UnknownTask"
  var taskDescription : String? = ""
  var teammateID      : String?
  var created         : Date = Date()
  var expires         : Date?
  var state           : TaskState = .toDo
  var type            : TaskType = .unknown
  var complexity      : TaskComplexity = .unknown
  
  static func primaryKey() -> String? { "id" }
}
