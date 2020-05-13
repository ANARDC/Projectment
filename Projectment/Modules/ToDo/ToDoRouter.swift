//
//  ToDoRouter.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class ToDoRouter: ToDoRouterProtocol {
  
  // MARK: properties
  weak var presenter: ToDoRouterPresenterProtocol!
  
  init(_ presenter: ToDoRouterPresenterProtocol) {
    self.presenter = presenter
  }
  
  func goToAddTaskScreen(from toDoView: ToDoUIProtocol) {
    let addTaskScreen = AddTaskViewController()
    toDoView.navigationController?.pushViewController(addTaskScreen, animated: true)
  }
  
  func goToTeamListScreen(from toDoView: ToDoUIProtocol) {
    let teamListScreen = TeamListViewController()
    toDoView.navigationController?.pushViewController(teamListScreen, animated: true)
  }
}
