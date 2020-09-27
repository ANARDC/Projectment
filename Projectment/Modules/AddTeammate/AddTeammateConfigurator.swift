//
//  AddTeammateConfigurator.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

final class AddTeammateConfigurator: AddTeammateConfiguratorProtocol {
  
  // MARK: properties
  var presenter  : AddTeammatePresenterGeneralProtocol!
  var interactor : AddTeammateInteractorProtocol!
  var router     : AddTeammateRouterProtocol!
  
  init(_ view: AddTeammateUIProtocol) {
    let input = AddTeammateInput(id: PublishSubject<String>(),
                                 name: PublishSubject<String>(),
                                 lastName: PublishSubject<String>(),
                                 job: PublishSubject<Job>(),
                                 post: PublishSubject<Post>(),
                                 addButton: PublishSubject<Void>())
    let output = AddTeammateOutput(dataIsValid: PublishSubject<Bool>())
    
    self.presenter = AddTeammatePresenter(view, input, output)
    
    let dataService = DataService()
    
    self.interactor = AddTeammateInteractor(self.presenter, dataService)
    self.router     = AddTeammateRouter(self.presenter)
    
    self.presenter.interactor = self.interactor
    self.presenter.router     = self.router
  }
  
  func configure(_ view: AddTeammateViewProtocol) {
    view.presenter = self.presenter
  }
}
