//
//  AddTaskRouter.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit


// MARK: - class

final class AddTaskRouter: AddTaskRouterProtocol {
  
  // MARK: properties
  weak var presenter: AddTaskRouterPresenterProtocol!
  
  init(_ presenter: AddTaskRouterPresenterProtocol) {
    self.presenter = presenter
  }
  
  func back(from addTaskView: AddTaskUIProtocol) {
    addTaskView.navigationController?.popViewController(animated: true)
  }
}
