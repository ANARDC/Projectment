//
//  AddTaskPresenter.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class AddTaskPresenter: AddTaskPresenterGeneralProtocol {
  
  // MARK: properties
  
  weak var view           : AddTaskUIProtocol!
  internal var interactor : AddTaskInteractorProtocol!
  internal var router     : AddTaskRouterProtocol!
  
  init(_ view: AddTaskUIProtocol) {
    self.view = view
  }
}

// MARK: - View Life Cycle

extension AddTaskPresenter: AddTaskLifeCyclePresenterProtocol {
  func viewDidLoad() {
    self.view.makeNavBar()
  }
}

// MARK: - View Actions

extension AddTaskPresenter: AddTaskActionsPresenterProtocol {
  
}
