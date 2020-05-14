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
  
  func deleteTask(with id: String?) {
    self.dataService.delete(entityType: Task.self, entityID: id)
  }
}
