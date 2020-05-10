//
//  InProgressProtocols.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

// MARK: View

protocol InProgressViewProtocol: UIViewController, InProgressUIProtocol {
  var presenter: InProgressViewPresenterProtocol! { get set }
}

protocol InProgressUIProtocol: class {
  
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
  
}

protocol InProgressInteractorPresenterProtocol: class {
  
}

protocol InProgressRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol InProgressInteractorProtocol: class {
  
}

// MARK: Router

protocol InProgressRouterProtocol: class {
  
}

// MARK: Configurator

protocol InProgressConfiguratorProtocol {
  func configure(_ view: InProgressViewProtocol)
}
