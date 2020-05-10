//
//  InProgressRouter.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit


// MARK: - class

final class InProgressRouter: InProgressRouterProtocol {
  
  // MARK: properties
  weak var presenter: InProgressRouterPresenterProtocol!
  
  init(_ presenter: InProgressRouterPresenterProtocol) {
    self.presenter = presenter
  }
}
