//
//  AddTaskConfigurator.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

final class AddTaskConfigurator: AddTaskConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : AddTaskPresenterGeneralProtocol!
  var interactor : AddTaskInteractorProtocol!
  var router     : AddTaskRouterProtocol!
  
  init(_ view: AddTaskUIProtocol) {
    let input = AddTaskInput(title: PublishSubject<String>(),
                             taskDescription: PublishSubject<String?>(),
                             teammateID: PublishSubject<String?>(),
                             expires: PublishSubject<Date?>(),
                             state: PublishSubject<TaskState>(),
                             type: PublishSubject<TaskType>(),
                             complexity: PublishSubject<TaskComplexity>(),
                             addButton: PublishSubject<Void>())
    let output = AddTaskOutput(dataIsValid: PublishSubject<Bool>())
    
    self.presenter = AddTaskPresenter(view, input, output)
    
    let dataService = DataService()
    
    self.interactor = AddTaskInteractor(self.presenter, dataService)
    self.router     = AddTaskRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: AddTaskViewProtocol) {
    view.presenter = self.presenter
  }
}
