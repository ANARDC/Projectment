//
//  DoneRouter.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit


// MARK: - class

final class DoneRouter: DoneRouterProtocol {
  
  // MARK: properties
  weak var presenter: DoneRouterPresenterProtocol!
  
  init(_ presenter: DoneRouterPresenterProtocol) {
    self.presenter = presenter
  }
}
