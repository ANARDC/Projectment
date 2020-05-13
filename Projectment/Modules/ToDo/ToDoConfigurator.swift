//
//  ToDoConfigurator.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

final class ToDoConfigurator: ToDoConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : ToDoPresenterGeneralProtocol!
  var interactor : ToDoInteractorProtocol!
  var router     : ToDoRouterProtocol!
  
  init(_ view: ToDoUIProtocol) {
    self.presenter = ToDoPresenter(view)
    
    let dataService = DataService()
    
    self.interactor = ToDoInteractor(self.presenter, dataService)
    self.router     = ToDoRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: ToDoViewProtocol) {
    view.presenter = self.presenter
  }
}
