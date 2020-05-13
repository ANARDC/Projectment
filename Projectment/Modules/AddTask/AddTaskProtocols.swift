//
//  AddTaskProtocols.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol AddTaskViewProtocol: AddTaskUIProtocol {
  var presenter: AddTaskViewPresenterProtocol! { get set }
}

protocol AddTaskUIProtocol: UIViewController {
  func makeNavBar()
}

// MARK: Presenter

typealias AddTaskPresenterGeneralProtocol = AddTaskViewPresenterProtocol & AddTaskInteractorPresenterProtocol & AddTaskRouterPresenterProtocol

protocol AddTaskViewPresenterProtocol: AddTaskLifeCyclePresenterProtocol, AddTaskActionsPresenterProtocol {
  var view       : AddTaskUIProtocol! { get set }
  var interactor : AddTaskInteractorProtocol! { get set }
  var router     : AddTaskRouterProtocol! { get set }
}

protocol AddTaskLifeCyclePresenterProtocol: class {
  func viewDidLoad()
  func traitCollectionDidChange()
}

protocol AddTaskActionsPresenterProtocol: class {
  
}

protocol AddTaskInteractorPresenterProtocol: class {
  
}

protocol AddTaskRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol AddTaskInteractorProtocol: class {
  
}

// MARK: Router

protocol AddTaskRouterProtocol: class {
  
}

// MARK: Configurator

protocol AddTaskConfiguratorProtocol {
  func configure(_ view: AddTaskViewProtocol)
}
