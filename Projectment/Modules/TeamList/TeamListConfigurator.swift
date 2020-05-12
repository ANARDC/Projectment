//
//  TeamListConfigurator.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

// MARK: class

final class TeamListConfigurator: TeamListConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : TeamListPresenterGeneralProtocol!
  var interactor : TeamListInteractorProtocol!
  var router     : TeamListRouterProtocol!
  
  init(_ view: TeamListUIProtocol) {
    self.presenter = TeamListPresenter(view)
    
    self.interactor = TeamListInteractor(self.presenter)
    self.router     = TeamListRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: TeamListViewProtocol) {
    view.presenter = self.presenter
  }
}
