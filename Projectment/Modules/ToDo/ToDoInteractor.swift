//
//  ToDoInteractor.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

final class ToDoInteractor: ToDoInteractorProtocol {
  
  // MARK: properties
  weak var presenter : ToDoInteractorPresenterProtocol!
  var dataService    : DataService
  
  init(_ presenter: ToDoInteractorPresenterProtocol, _ dataService: DataService) {
    self.presenter   = presenter
    self.dataService = dataService
  }
  
  var tasks: [Task]? {
    self.dataService.toDoTasks
  }
  
  var team: [Teammate]? {
    self.dataService.team
  }
  
  func deleteTask(with id: String?) {
    self.dataService.delete(entityType: Task.self, entityID: id)
  }
  
  func moveTaskToToDo(with id: String?) {
    self.dataService.moveTaskToToDo(with: id)
  }
  
  func moveTaskToInProgress(with id: String?) {
    self.dataService.moveTaskToInProgress(with: id)
  }
  
  func moveTaskToDone(with id: String?) {
    self.dataService.moveTaskToDone(with: id)
  }
}
