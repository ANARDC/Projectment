//
//  InProgressPresenter.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class InProgressPresenter: InProgressPresenterGeneralProtocol {
  
  // MARK: properties
  
  weak var view           : InProgressUIProtocol!
  internal var interactor : InProgressInteractorProtocol!
  internal var router     : InProgressRouterProtocol!
  
  init(_ view: InProgressUIProtocol) {
    self.view = view
  }
}

// MARK: - View Life Cycle

extension InProgressPresenter: InProgressLifeCyclePresenterProtocol {
  func viewWillAppear() {
    self.interactor.dataService = DataService()
    self.view.setTasks(for: self.interactor.tasks)
    self.view.makeTabBar()
  }
  
  func viewDidLoad() {
    self.view.setTasks(for: self.interactor.tasks)
    self.view.makeNavBar()
  }
}

// MARK: - View Actions

extension InProgressPresenter: InProgressActionsPresenterProtocol {
  func deleteTask(with id: String?) {
    self.interactor.deleteTask(with: id)
  }
  
  func addTaskButton() {
    self.router.goToAddTaskScreen(from: self.view)
  }
  
  func showTeamListButton() {
    self.router.goToTeamListScreen(from: self.view)
  }
  
  func moveTaskToToDo(with id: String?) {
    self.interactor.moveTaskToToDo(with: id)
  }
  
  func moveTaskToInProgress(with id: String?) {
    self.interactor.moveTaskToInProgress(with: id)
  }
  
  func moveTaskToDone(with id: String?) {
    self.interactor.moveTaskToDone(with: id)
  }
  
  func whoButton(with id: String?) {
    let task     = self.interactor.tasks?.filter { $0.id == id }.first
    let teammate = self.interactor.team?.filter { $0.id == task?.teammateID }.first
    self.view.makeTeammateInfoView(for: teammate)
  }
  
  func dateButton(with id: String?) {
    let task    = self.interactor.tasks?.filter { $0.id == id }.first
    let created = task?.created
    let expires = task?.expires
    self.view.makeDateInfoView(for: created, expires)
  }
}
