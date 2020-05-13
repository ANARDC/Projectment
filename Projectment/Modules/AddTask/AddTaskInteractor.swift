//
//  AddTaskInteractor.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class AddTaskInteractor: AddTaskInteractorProtocol {
  
  // MARK: properties
  weak var presenter : AddTaskInteractorPresenterProtocol!
  var dataService    : DataService
  
  init(_ presenter: AddTaskInteractorPresenterProtocol, _ dataService: DataService) {
    self.presenter    = presenter
    self.dataService = dataService
  }
  
  var team: [Teammate]? {
    self.dataService.team
  }
}
