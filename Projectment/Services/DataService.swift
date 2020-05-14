//
//  DataService.swift
//  Projectment
//
//  Created by Anar on 11.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import Unrealm
import RealmSwift
import RxSwift

final class DataService {
  let realm = try? Realm()
  
  init() {
    print(Realm.Configuration.defaultConfiguration.fileURL)
  }
  
  func save<T: Realmable>(for entity: T) -> Observable<RealmOperationState> {
    var state: RealmOperationState?
    
    do {
      try realm?.write {
        self.realm?.add(entity)
        state = .success
      }
    } catch {
      state = .error
    }
    
    return Observable.just(state ?? .error)
  }
  
  private var tasks: [Task]? {
    [Task(id: "1",
          title: "Make login screen design",
          taskDescription: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.toDo.rawValue,
          type: TaskType.design.rawValue,
          complexity: TaskComplexity.easy.rawValue),
     Task(id: "2",
          title: "Configure GitHub",
          taskDescription: "Delegate to head of development team configuring github for remote control versions of the product",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.toDo.rawValue,
          type: TaskType.development.rawValue,
          complexity: TaskComplexity.middle.rawValue),
     Task(id: "3",
          title: "Make login screen design",
          taskDescription: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.toDo.rawValue,
          type: TaskType.management.rawValue,
          complexity: TaskComplexity.hard.rawValue),
     Task(id: "4",
          title: "Configure GitHub",
          taskDescription: "Delegate to head of development team configuring github for remote control versions of the product",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.inProgress.rawValue,
          type: TaskType.planning.rawValue,
          complexity: TaskComplexity.easy.rawValue),
     Task(id: "5",
          title: "Make login screen design",
          taskDescription: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.inProgress.rawValue,
          type: TaskType.testing.rawValue,
          complexity: TaskComplexity.easy.rawValue),
     Task(id: "6",
          title: "Configure GitHub",
          taskDescription: "Delegate to head of development team configuring github for remote control versions of the product",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.done.rawValue,
          type: TaskType.development.rawValue,
          complexity: TaskComplexity.easy.rawValue),
     Task(id: "7",
          title: "Make login screen design",
          taskDescription: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.done.rawValue,
          type: TaskType.design.rawValue,
          complexity: TaskComplexity.easy.rawValue),
     Task(id: "8",
          title: "Configure GitHub",
          taskDescription: "Delegate to head of development team configuring github for remote control versions of the product",
          teammateID: self.team?.randomElement()?.id,
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: TaskState.toDo.rawValue,
          type: TaskType.development.rawValue,
          complexity: TaskComplexity.easy.rawValue)]
  }
  
  lazy var team: [Teammate]? = {
    self.realm?.objects(Teammate.self).map { $0 }
  }()
  
  var tasksIDList: [String]? {
    self.tasks?.map { $0.id }
  }
  
  var teammatesIDList: [String]? {
    self.team?.map { $0.id }
  }
  
  var toDoTasks: [Task]? {
    self.tasks?.filter { $0.state == TaskState.toDo.rawValue }
  }
  
  var inProgressTasks: [Task]? {
    self.tasks?.filter { $0.state == TaskState.inProgress.rawValue }
  }
  
  var doneTasks: [Task]? {
    self.tasks?.filter { $0.state == TaskState.done.rawValue }
  }
}
