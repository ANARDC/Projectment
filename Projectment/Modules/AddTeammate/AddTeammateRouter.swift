//
//  AddTeammateRouter.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class AddTeammateRouter: AddTeammateRouterProtocol {
  
  // MARK: properties
  weak var presenter: AddTeammateRouterPresenterProtocol!
  
  init(_ presenter: AddTeammateRouterPresenterProtocol) {
    self.presenter = presenter
  }
}
