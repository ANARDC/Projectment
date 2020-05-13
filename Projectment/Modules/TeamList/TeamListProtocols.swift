//
//  TeamListProtocols.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol TeamListViewProtocol: TeamListUIProtocol {
  var presenter: TeamListViewPresenterProtocol! { get set }
}

protocol TeamListUIProtocol: UIViewController {
  func makeNavBar()
}

// MARK: Presenter

typealias TeamListPresenterGeneralProtocol = TeamListViewPresenterProtocol & TeamListInteractorPresenterProtocol & TeamListRouterPresenterProtocol

protocol TeamListViewPresenterProtocol: TeamListLifeCyclePresenterProtocol, TeamListActionsPresenterProtocol {
  var view       : TeamListUIProtocol! { get set }
  var interactor : TeamListInteractorProtocol! { get set }
  var router     : TeamListRouterProtocol! { get set }
}

protocol TeamListLifeCyclePresenterProtocol: class {
  func viewDidLoad()
  func traitCollectionDidChange()
}

protocol TeamListActionsPresenterProtocol: class {
  
}

protocol TeamListInteractorPresenterProtocol: class {
  
}

protocol TeamListRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol TeamListInteractorProtocol: class {
  
}

// MARK: Router

protocol TeamListRouterProtocol: class {
  
}

// MARK: Configurator

protocol TeamListConfiguratorProtocol {
  func configure(_ view: TeamListViewProtocol)
}
