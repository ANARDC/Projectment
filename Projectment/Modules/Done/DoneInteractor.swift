//
//  DoneInteractor.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class DoneInteractor: DoneInteractorProtocol {
  
  // MARK: properties
  weak var presenter : DoneInteractorPresenterProtocol!
  var dataService    : DataService!
  
  init(_ presenter: DoneInteractorPresenterProtocol, _ dataService: DataService) {
    self.presenter  = presenter
    self.dataService = dataService
  }
  
  var tasks: [Task]? {
    self.dataService.doneTasks
  }
}
