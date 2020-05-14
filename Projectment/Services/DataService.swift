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
  
  private lazy var tasks: [Task]? = {
    self.realm?.objects(Task.self).map { $0 }
  }()
  
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
