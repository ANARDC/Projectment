//
//  DonePresenter.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class DonePresenter: DonePresenterGeneralProtocol {
  
  // MARK: properties
  
  weak var view           : DoneUIProtocol!
  internal var interactor : DoneInteractorProtocol!
  internal var router     : DoneRouterProtocol!
  
  init(_ view: DoneUIProtocol) {
    self.view = view
  }
}

// MARK: - View Life Cycle

extension DonePresenter: DoneLifeCyclePresenterProtocol {
  func viewDidLoad() {
    
  }
}

// MARK: - View Actions

extension DonePresenter: DoneActionsPresenterProtocol {
  
}
