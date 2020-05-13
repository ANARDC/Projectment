//
//  AddTeammatePresenter.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class AddTeammatePresenter: AddTeammatePresenterGeneralProtocol {
  
  // MARK: properties
  
  weak var view           : AddTeammateUIProtocol!
  internal var interactor : AddTeammateInteractorProtocol!
  internal var router     : AddTeammateRouterProtocol!
  
  init(_ view: AddTeammateUIProtocol) {
    self.view = view
  }
}

// MARK: - View Life Cycle

extension AddTeammatePresenter: AddTeammateLifeCyclePresenterProtocol {
  func viewDidLoad() {
    self.view.makeView()
    self.view.makeNavBar()
    self.view.makeNameTextField()
    self.view.makeLastNameTextField()
    self.view.makeJobAndPostPickerView()
    self.view.makeAddTeammateButton()
  }
  
  func traitCollectionDidChange() {
    self.view.changeTheme()
  }
}

// MARK: - View Actions

extension AddTeammatePresenter: AddTeammateActionsPresenterProtocol {
  
}
