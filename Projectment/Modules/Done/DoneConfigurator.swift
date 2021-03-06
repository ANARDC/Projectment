//
//  DoneConfigurator.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class DoneConfigurator: DoneConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : DonePresenterGeneralProtocol!
  var interactor : DoneInteractorProtocol!
  var router     : DoneRouterProtocol!
  
  init(_ view: DoneUIProtocol) {
    self.presenter = DonePresenter(view)
    
    let dataService = DataService()
    
    self.interactor = DoneInteractor(self.presenter, dataService)
    self.router     = DoneRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: DoneViewProtocol) {
    view.presenter = self.presenter
  }
}
