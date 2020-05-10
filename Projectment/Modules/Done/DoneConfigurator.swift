//
//  DoneConfigurator.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

// MARK: class

final class DoneConfigurator: DoneConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : DonePresenterGeneralProtocol!
  var interactor : DoneInteractorProtocol!
  var router     : DoneRouterProtocol!
  
  init(_ view: DoneUIProtocol) {
    self.presenter = DonePresenter(view)
    
    self.interactor = DoneInteractor(self.presenter)
    self.router     = DoneRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: DoneViewProtocol) {
    view.presenter = self.presenter
  }
}
