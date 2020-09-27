//
//  TaskState.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import Unrealm

enum TaskState: String, CaseIterable, RealmableEnum {
  case toDo
  case inProgress
  case done
}
