//
//  AddTeammateProtocols.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol AddTeammateViewProtocol: UIViewController, AddTeammateUIProtocol {
  var presenter: AddTeammateViewPresenterProtocol! { get set }
}

protocol AddTeammateUIProtocol: class {
  func makeView()
  func makeNavBar()
}

// MARK: Presenter

typealias AddTeammatePresenterGeneralProtocol = AddTeammateViewPresenterProtocol & AddTeammateInteractorPresenterProtocol & AddTeammateRouterPresenterProtocol

protocol AddTeammateViewPresenterProtocol: AddTeammateLifeCyclePresenterProtocol, AddTeammateActionsPresenterProtocol {
  var view       : AddTeammateUIProtocol! { get set }
  var interactor : AddTeammateInteractorProtocol! { get set }
  var router     : AddTeammateRouterProtocol! { get set }
}

protocol AddTeammateLifeCyclePresenterProtocol: class {
  func viewDidLoad()
}

protocol AddTeammateActionsPresenterProtocol: class {
  
}

protocol AddTeammateInteractorPresenterProtocol: class {
  
}

protocol AddTeammateRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol AddTeammateInteractorProtocol: class {
  
}

// MARK: Router

protocol AddTeammateRouterProtocol: class {
  
}

// MARK: Configurator

protocol AddTeammateConfiguratorProtocol {
  func configure(_ view: AddTeammateViewProtocol)
}
