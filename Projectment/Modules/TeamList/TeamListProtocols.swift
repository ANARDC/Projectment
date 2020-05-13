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

protocol TeamListUIProtocol: UIViewController, TeamListViewDataProtocol {
  func makeNavBar()
}

protocol TeamListViewDataProtocol {
  func setTeam(for team: [Teammate]?)
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
}

protocol TeamListActionsPresenterProtocol: class {
  func goToAddTeammateScreen()
}

protocol TeamListInteractorPresenterProtocol: class {
  
}

protocol TeamListRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol TeamListInteractorProtocol: class {
  var team: [Teammate]? { get }
}

// MARK: Router

protocol TeamListRouterProtocol: class {
  func goToAddTeammateScreen(from teamListview: TeamListUIProtocol)
}

// MARK: Configurator

protocol TeamListConfiguratorProtocol {
  func configure(_ view: TeamListViewProtocol)
}
