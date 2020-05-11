//
//  ToDoProtocols.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol ToDoViewProtocol: UIViewController, ToDoUIProtocol {
  var presenter: ToDoViewPresenterProtocol! { get set }
}

protocol ToDoUIProtocol: class, ToDoViewDataProtocol {
  func makeNavBar()
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
  func viewDidLoad()
}

protocol ToDoActionsPresenterProtocol: class {
  
}

protocol ToDoInteractorPresenterProtocol: class {
  
}

protocol ToDoRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol ToDoInteractorProtocol: class {
  var tasks: [Task]? { get }
}

// MARK: Router

protocol ToDoRouterProtocol: class {
  
}

// MARK: Configurator

protocol ToDoConfiguratorProtocol {
  func configure(_ view: ToDoViewProtocol)
}
