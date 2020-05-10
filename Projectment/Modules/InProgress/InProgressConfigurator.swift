//
//  InProgressConfigurator.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

// MARK: class

final class InProgressConfigurator: InProgressConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : InProgressPresenterGeneralProtocol!
  var interactor : InProgressInteractorProtocol!
  var router     : InProgressRouterProtocol!
  
  init(_ view: InProgressUIProtocol) {
    self.presenter = InProgressPresenter(view)
    
    self.interactor = InProgressInteractor(self.presenter)
    self.router     = InProgressRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: InProgressViewProtocol) {
    view.presenter = self.presenter
  }
}
