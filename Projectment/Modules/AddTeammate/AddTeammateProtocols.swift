//
//  AddTeammateProtocols.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit
import RxSwift

// MARK: View

protocol AddTeammateViewProtocol: AddTeammateUIProtocol {
  var presenter: AddTeammateViewPresenterProtocol! { get set }
}

protocol AddTeammateUIProtocol: UIViewController, AddTeammateViewReactive {
  func changeTheme()
  func makeView()
  func makeNavBar()
  func makeNameTextField()
  func makeLastNameTextField()
  func makeIDTextField()
  func makeJobAndPostPickerView()
  func makeAddTeammateButton()
  func changeAddTeammateButton(isValid: Bool)
}

protocol AddTeammateViewReactive {
  func bindNameSubscriber()
  func bindLastNameSubscriber()
  func bindIDSubscriber()
  func bindJobSubcriber()
  func bindPostSubcriber()
  func bindAddTeammateButtonSubscriber()
}

// MARK: Presenter

typealias AddTeammatePresenterGeneralProtocol = AddTeammateViewPresenterProtocol & AddTeammateInteractorPresenterProtocol & AddTeammateRouterPresenterProtocol

protocol AddTeammateViewPresenterProtocol: AddTeammateLifeCyclePresenterProtocol, AddTeammatePresenterReactiveProtocol {
  var view       : AddTeammateUIProtocol! { get set }
  var interactor : AddTeammateInteractorProtocol! { get set }
  var router     : AddTeammateRouterProtocol! { get set }
}

protocol AddTeammateLifeCyclePresenterProtocol: class {
  func viewDidLoad()
  func traitCollectionDidChange()
}

protocol AddTeammatePresenterReactiveProtocol {
  var input  : AddTeammateInput { get }
  var output : AddTeammateOutput { get }
}

protocol AddTeammateInteractorPresenterProtocol: class {
  
}

protocol AddTeammateRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol AddTeammateInteractorProtocol: class {
  func saveTeammate(for data: Teammate) -> Observable<RealmOperationState>
  
  var teammatesIDList: [String]? { get }
}

// MARK: Router

protocol AddTeammateRouterProtocol: class {
  
}

// MARK: Configurator

protocol AddTeammateConfiguratorProtocol {
  func configure(_ view: AddTeammateViewProtocol)
}
