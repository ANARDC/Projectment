//
//  InProgressProtocols.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol InProgressViewProtocol: InProgressUIProtocol {
  var presenter: InProgressViewPresenterProtocol! { get set }
}

protocol InProgressUIProtocol: UIViewController, InProgressViewDataProtocol {
  func makeNavBar()
}

protocol InProgressViewDataProtocol {
  func setTasks(for tasks: [Task]?)
}

// MARK: Presenter

typealias InProgressPresenterGeneralProtocol = InProgressViewPresenterProtocol & InProgressInteractorPresenterProtocol & InProgressRouterPresenterProtocol

protocol InProgressViewPresenterProtocol: InProgressLifeCyclePresenterProtocol, InProgressActionsPresenterProtocol {
  var view       : InProgressUIProtocol! { get set }
  var interactor : InProgressInteractorProtocol! { get set }
  var router     : InProgressRouterProtocol! { get set }
}

protocol InProgressLifeCyclePresenterProtocol: class {
  func viewDidLoad()
}

protocol InProgressActionsPresenterProtocol: class {
  func addTaskButton()
  func showTeamListButton()
}

protocol InProgressInteractorPresenterProtocol: class {
  
}

protocol InProgressRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol InProgressInteractorProtocol: class {
  var tasks: [Task]? { get }
}

// MARK: Router

protocol InProgressRouterProtocol: class {
  func goToAddTaskScreen(from inProgressView: InProgressUIProtocol)
  func goToTeamListScreen(from inProgressView: InProgressUIProtocol)
}

// MARK: Configurator

protocol InProgressConfiguratorProtocol {
  func configure(_ view: InProgressViewProtocol)
}
