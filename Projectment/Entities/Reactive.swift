//
//  Reactive.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

struct AddTeammateInput {
  let id        : PublishSubject<String>
  let name      : PublishSubject<String>
  let lastName  : PublishSubject<String>
  let job       : PublishSubject<Job>
  let post      : PublishSubject<TeammatePost>
  let addButton : PublishSubject<Void>
}

struct AddTeammateOutput {
  let dataIsValid: PublishSubject<Bool>
}

struct AddTaskInput {
  let title           : PublishSubject<String>
  let taskDescription : PublishSubject<String?>
  let teammateID      : PublishSubject<String?>
  let expires         : PublishSubject<Date?>
  let state           : PublishSubject<TaskState>
  let type            : PublishSubject<TaskType>
  let complexity      : PublishSubject<TaskComplexity>
  let addButton       : PublishSubject<Void>
}

struct AddTaskOutput {
  let dataIsValid: PublishSubject<Bool>
}
