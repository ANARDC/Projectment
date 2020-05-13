//
//  DoneRouter.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit


// MARK: - class

final class DoneRouter: DoneRouterProtocol {
  
  // MARK: properties
  weak var presenter: DoneRouterPresenterProtocol!
  
  init(_ presenter: DoneRouterPresenterProtocol) {
    self.presenter = presenter
  }
  
  func goToAddTaskScreen(from doneView: DoneUIProtocol) {
    let addTaskScreen = AddTaskViewController()
    doneView.navigationController?.pushViewController(addTaskScreen, animated: true)
  }
  
  func goToTeamListScreen(from doneView: DoneUIProtocol) {
    let teamListScreen = TeamListViewController()
    doneView.navigationController?.pushViewController(teamListScreen, animated: true)
  }
}
