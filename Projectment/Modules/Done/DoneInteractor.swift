//
//  DoneInteractor.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class DoneInteractor: DoneInteractorProtocol {
  
  // MARK: properties
  weak var presenter: DoneInteractorPresenterProtocol!
  
  init(_ presenter: DoneInteractorPresenterProtocol) {
    self.presenter = presenter
  }
}
