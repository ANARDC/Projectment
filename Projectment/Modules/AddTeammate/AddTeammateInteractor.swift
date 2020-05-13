//
//  AddTeammateInteractor.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class AddTeammateInteractor: AddTeammateInteractorProtocol {
  
  // MARK: properties
  weak var presenter: AddTeammateInteractorPresenterProtocol!
  
  init(_ presenter: AddTeammateInteractorPresenterProtocol) {
    self.presenter = presenter
  }
}
