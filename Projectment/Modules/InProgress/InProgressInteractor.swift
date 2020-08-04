//
//  InProgressInteractor.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class InProgressInteractor: InProgressInteractorProtocol {
  
  // MARK: properties
  weak var presenter : InProgressInteractorPresenterProtocol!
  var dataService    : DataService
  
  init(_ presenter: InProgressInteractorPresenterProtocol, _ dataService: DataService) {
    self.presenter   = presenter
    self.dataService = dataService
  }
  
  var tasks: [Task]? {
    self.dataService.inProgressTasks
  }
  
  var team: [Teammate]? {
    self.dataService.team
  }
  
  func deleteTask(with id: String?) {
    self.dataService.delete(entityType: Task.self, entityID: id)
  }
  
  func changeTaskState(with id: String?, to state: TaskState) {
    self.dataService.changeTaskState(with: id, to: state)
  }
}
