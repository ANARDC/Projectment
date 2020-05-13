//
//  TeamListPresenter.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class TeamListPresenter: TeamListPresenterGeneralProtocol {
  
  // MARK: properties
  
  weak var view           : TeamListUIProtocol!
  internal var interactor : TeamListInteractorProtocol!
  internal var router     : TeamListRouterProtocol!
  
  init(_ view: TeamListUIProtocol) {
    self.view = view
  }
}

// MARK: - View Life Cycle

extension TeamListPresenter: TeamListLifeCyclePresenterProtocol {
  func viewWillAppear() {
    self.interactor.dataService = DataService()
    self.view.setTeam(for: self.interactor.team)
  }
  
  func viewDidLoad() {
    self.view.setTeam(for: self.interactor.team)
    self.view.makeNavBar()
    self.view.makeTabBar()
  }
}

// MARK: - View Actions

extension TeamListPresenter: TeamListActionsPresenterProtocol {
  func goToAddTeammateScreen() {
    self.router.goToAddTeammateScreen(from: self.view)
  }
}
