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
  func viewDidLoad() {
    self.view.setTeam(for: self.interactor.team)
    self.view.makeNavBar()
  }
}

// MARK: - View Actions

extension TeamListPresenter: TeamListActionsPresenterProtocol {
  
}
