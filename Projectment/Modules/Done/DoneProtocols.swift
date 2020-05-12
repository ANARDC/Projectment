//
//  DoneProtocols.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol DoneViewProtocol: UIViewController, DoneUIProtocol {
  var presenter: DoneViewPresenterProtocol! { get set }
}

protocol DoneUIProtocol: class, DoneViewDataProtocol {
  func makeNavBar()
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
  func viewDidLoad()
}

protocol DoneActionsPresenterProtocol: class {
  
}

protocol DoneInteractorPresenterProtocol: class {
  
}

protocol DoneRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol DoneInteractorProtocol: class {
  var tasks: [Task]? { get }
}

// MARK: Router

protocol DoneRouterProtocol: class {
  
}

// MARK: Configurator

protocol DoneConfiguratorProtocol {
  func configure(_ view: DoneViewProtocol)
}
