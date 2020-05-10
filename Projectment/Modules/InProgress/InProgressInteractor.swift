//
//  InProgressInteractor.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class InProgressInteractor: InProgressInteractorProtocol {
  
  // MARK: properties
  weak var presenter: InProgressInteractorPresenterProtocol!
  
  init(_ presenter: InProgressInteractorPresenterProtocol) {
    self.presenter = presenter
  }
}
