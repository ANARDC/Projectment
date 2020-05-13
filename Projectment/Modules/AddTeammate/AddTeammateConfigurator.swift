//
//  AddTeammateConfigurator.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class AddTeammateConfigurator: AddTeammateConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : AddTeammatePresenterGeneralProtocol!
  var interactor : AddTeammateInteractorProtocol!
  var router     : AddTeammateRouterProtocol!
  
  init(_ view: AddTeammateUIProtocol) {
    self.presenter = AddTeammatePresenter(view)
    
    self.interactor = AddTeammateInteractor(self.presenter)
    self.router     = AddTeammateRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: AddTeammateViewProtocol) {
    view.presenter = self.presenter
  }
}
