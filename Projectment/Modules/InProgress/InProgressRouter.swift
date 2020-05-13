//
//  InProgressRouter.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit


// MARK: - class

final class InProgressRouter: InProgressRouterProtocol {
  
  // MARK: properties
  weak var presenter: InProgressRouterPresenterProtocol!
  
  init(_ presenter: InProgressRouterPresenterProtocol) {
    self.presenter = presenter
  }
  
  func goToAddTaskScreen(from inProgressView: InProgressUIProtocol) {
    let addTaskScreen = AddTaskViewController()
    inProgressView.navigationController?.pushViewController(addTaskScreen, animated: true)
  }
  
  func goToTeamListScreen(from inProgressView: InProgressUIProtocol) {
    let teamListScreen = TeamListViewController(context: TeamContext.shared, style: .grouped)
    inProgressView.navigationController?.pushViewController(teamListScreen, animated: true)
  }
}
