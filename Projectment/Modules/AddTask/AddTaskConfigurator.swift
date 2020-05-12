//
//  AddTaskConfigurator.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

// MARK: class

final class AddTaskConfigurator: AddTaskConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : AddTaskPresenterGeneralProtocol!
  var interactor : AddTaskInteractorProtocol!
  var router     : AddTaskRouterProtocol!
  
  init(_ view: AddTaskUIProtocol) {
    self.presenter = AddTaskPresenter(view)
    
    self.interactor = AddTaskInteractor(self.presenter)
    self.router     = AddTaskRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: AddTaskViewProtocol) {
    view.presenter = self.presenter
  }
}
