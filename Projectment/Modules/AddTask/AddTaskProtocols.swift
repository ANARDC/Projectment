//
//  AddTaskProtocols.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit
import RxSwift

// MARK: View

protocol AddTaskViewProtocol: AddTaskUIProtocol {
  var presenter: AddTaskViewPresenterProtocol! { get set }
}

protocol AddTaskUIProtocol: UIViewController, AddTaskViewReactive, AddTaskViewDataProtocol {
  func changeTheme()
  func makeView()
  func makeNavBar()
  func makeTabBar()
  func makeTitleTextField()
  func makeDescriptionTextView()
  func makeWhoPickerView()
  func makeExpiresPickerView()
  func makeStateAndTypeAndComplexityPickerView()
  func makeAddTaskButton()
  func changeAddTaskButton(isValid: Bool)
}

protocol AddTaskViewReactive {
  func bindTitleSubscriber()
  func bindDescriptionSubscriber()
  func bindWhoSubscriber()
  func bindExpiresSubscriber()
  func bindStateSubscriber()
  func bindTypeSubscriber()
  func bindComplexitySubscriber()
  func bindAddTaskButtonSubscriber()
}

protocol AddTaskViewDataProtocol {
  func setTeam(for data: [Teammate]?)
}

// MARK: Presenter

typealias AddTaskPresenterGeneralProtocol = AddTaskViewPresenterProtocol & AddTaskInteractorPresenterProtocol & AddTaskRouterPresenterProtocol

protocol AddTaskViewPresenterProtocol: AddTaskLifeCyclePresenterProtocol, AddTaskPresenterReactiveProtocol {
  var view       : AddTaskUIProtocol! { get set }
  var interactor : AddTaskInteractorProtocol! { get set }
  var router     : AddTaskRouterProtocol! { get set }
}

protocol AddTaskLifeCyclePresenterProtocol: class {
  func viewDidLoad()
  func traitCollectionDidChange()
}

protocol AddTaskPresenterReactiveProtocol {
  var input  : AddTaskInput { get }
  var output : AddTaskOutput { get }
}

protocol AddTaskInteractorPresenterProtocol: class {
  
}

protocol AddTaskRouterPresenterProtocol: class {
  
}

// MARK: Interactor

protocol AddTaskInteractorProtocol: class {
  func saveTask(for task: Task) -> Observable<RealmOperationState>
  
  var team: [Teammate]? { get }
}

// MARK: Router

protocol AddTaskRouterProtocol: class {
  func back(from addTaskView: AddTaskUIProtocol)
}

// MARK: Configurator

protocol AddTaskConfiguratorProtocol {
  func configure(_ view: AddTaskViewProtocol)
}
