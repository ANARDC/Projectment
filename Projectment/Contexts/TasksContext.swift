//
//  TasksContext.swift
//  Projectment
//
//  Created by Anar on 11.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

struct TasksContext: Contextable {
  static var shared = TasksContext(info: ContextInfo(name: "Tasks Context",
                                                     description: "Interaction with tasks with different state",
                                                     scenesCount: 3))
  
  var info: ContextInfo
}
