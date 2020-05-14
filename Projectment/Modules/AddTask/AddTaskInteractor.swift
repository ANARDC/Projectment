//
//  AddTaskInteractor.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

final class AddTaskInteractor: AddTaskInteractorProtocol {
  
  // MARK: properties
  weak var presenter : AddTaskInteractorPresenterProtocol!
  var dataService    : DataService
  
  init(_ presenter: AddTaskInteractorPresenterProtocol, _ dataService: DataService) {
    self.presenter    = presenter
    self.dataService = dataService
  }
  
  func saveTask(for task: Task) -> Observable<RealmOperationState> {
    self.dataService.save(for: task)
  }
  
  var team: [Teammate]? {
    self.dataService.team
  }
}
