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
  
  func deleteTask(with id: String?) {
    self.dataService.delete(entityType: Task.self, entityID: id)
  }
}
