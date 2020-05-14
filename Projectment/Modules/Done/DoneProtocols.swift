//
//  DoneProtocols.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol DoneViewProtocol: DoneUIProtocol {
  var presenter: DoneViewPresenterProtocol! { get set }
}

protocol DoneUIProtocol: UIViewController, DoneViewDataProtocol {
  func makeNavBar()
  func makeTabBar()
}

protocol DoneViewDataProtocol {
  func setTasks(for tasks: [Task]?)
}

// MARK: Presenter

typealias DonePresenterGeneralProtocol = DoneViewPresenterProtocol & DoneInteractorPresenterProtocol & DoneRouterPresenterProtocol

protocol DoneViewPresenterProtocol: DoneLifeCyclePresenterProtocol, DoneActionsPresenterProtocol {
  var view       : DoneUIProtocol! { get set }
  var interactor : DoneInteractorProtocol! { get set }
  var router     : DoneRouterProtocol! { get set }
}

protocol DoneLifeCyclePresenterProtocol: class {
  func viewWillAppear()
  func viewDidLoad()
}

protocol DoneActionsPresenterProtocol: class {
  func deleteTask(with id: String?)
  func addTaskButton()
  func showTeamListButton()
}

protocol DoneInteractorPresenterProtocol: class {
  
}

protocol DoneRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol DoneInteractorProtocol: class {
  var dataService : DataService { get set }
  var tasks       : [Task]? { get }
  
  func deleteTask(with id: String?)
}

// MARK: Router

protocol DoneRouterProtocol: class {
  func goToAddTaskScreen(from doneView: DoneUIProtocol)
  func goToTeamListScreen(from doneView: DoneUIProtocol)
}

// MARK: Configurator

protocol DoneConfiguratorProtocol {
  func configure(_ view: DoneViewProtocol)
}
