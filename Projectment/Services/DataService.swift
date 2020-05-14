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
  var realm = try? Realm()
  
  init() {
    print(Realm.Configuration.defaultConfiguration.fileURL ?? "Realm Configuration File Cannot Be Found")
  }
  
  func save<Entity: Realmable & Entitiable>(for entity: Entity) -> Observable<RealmOperationState> {
    var state: RealmOperationState?
    
    do {
      try self.realm?.write {
        self.realm?.add(entity)
        state = .success
      }
    } catch {
      state = .error
    }
    
    return Observable.just(state ?? .error)
  }
  
  func delete<Entity: Realmable & Entitiable>(entityType: Entity.Type, entityID: String?) {
    if let entity = self.realm?.object(ofType: entityType, forPrimaryKey: entityID) {
      try? self.realm?.write {
        self.realm?.delete(entity)
      }
    }
  }
  
  func moveTaskToToDo(with id: String?) {
    if var entity = self.realm?.object(ofType: Task.self, forPrimaryKey: id) {
      entity.state = TaskState.toDo.rawValue
      try? self.realm?.write {
        self.realm?.add(entity, update: .modified)
      }
    }
  }
  
  func moveTaskToInProgress(with id: String?) {
    if var entity = self.realm?.object(ofType: Task.self, forPrimaryKey: id) {
      entity.state = TaskState.inProgress.rawValue
      try? self.realm?.write {
        self.realm?.add(entity, update: .modified)
      }
    }
  }
  
  func moveTaskToDone(with id: String?) {
    if var entity = self.realm?.object(ofType: Task.self, forPrimaryKey: id) {
      entity.state = TaskState.done.rawValue
      try? self.realm?.write {
        self.realm?.add(entity, update: .modified)
      }
    }
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
