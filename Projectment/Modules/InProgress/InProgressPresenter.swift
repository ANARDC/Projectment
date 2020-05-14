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
}
