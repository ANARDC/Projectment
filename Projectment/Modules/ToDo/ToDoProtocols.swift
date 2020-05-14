//
//  ToDoProtocols.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol ToDoViewProtocol: ToDoUIProtocol {
  var presenter: ToDoViewPresenterProtocol! { get set }
}

protocol ToDoUIProtocol: UIViewController, ToDoViewDataProtocol {
  func makeNavBar()
  func makeTabBar()
  func makeTeammateInfoView(for: Teammate?)
  func makeDateInfoView(for dates: (Date?, Date?))
}

protocol ToDoViewDataProtocol {
  func setTasks(for tasks: [Task]?)
}

// MARK: Presenter

typealias ToDoPresenterGeneralProtocol = ToDoViewPresenterProtocol & ToDoInteractorPresenterProtocol & ToDoRouterPresenterProtocol

protocol ToDoViewPresenterProtocol: ToDoLifeCyclePresenterProtocol, ToDoActionsPresenterProtocol {
  var view       : ToDoUIProtocol! { get set }
  var interactor : ToDoInteractorProtocol! { get set }
  var router     : ToDoRouterProtocol! { get set }
}

protocol ToDoLifeCyclePresenterProtocol: class {
  func viewWillAppear()
  func viewDidLoad()
}

protocol ToDoActionsPresenterProtocol: class {
  func deleteTask(with id: String?)
  func addTaskButton()
  func showTeamListButton()
  func moveTaskToToDo(with id: String?)
  func moveTaskToInProgress(with id: String?)
  func moveTaskToDone(with id: String?)
  func whoButton(with id: String?)
  func dateButton(with id: String?)
}

protocol ToDoInteractorPresenterProtocol: class {
  
}

protocol ToDoRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol ToDoInteractorProtocol: class {
  var dataService : DataService { get set }
  var tasks       : [Task]? { get }
  var team        : [Teammate]? { get }
  
  func deleteTask(with id: String?)
  func moveTaskToToDo(with id: String?)
  func moveTaskToInProgress(with id: String?)
  func moveTaskToDone(with id: String?)
}

// MARK: Router

protocol ToDoRouterProtocol: class {
  func goToAddTaskScreen(from toDoView: ToDoUIProtocol)
  func goToTeamListScreen(from toDoView: ToDoUIProtocol)
}

// MARK: Configurator

protocol ToDoConfiguratorProtocol {
  func configure(_ view: ToDoViewProtocol)
}
