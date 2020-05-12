//
//  TeamListRouter.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit


// MARK: - class

final class TeamListRouter: TeamListRouterProtocol {
  
  // MARK: properties
  weak var presenter: TeamListRouterPresenterProtocol!
  
  init(_ presenter: TeamListRouterPresenterProtocol) {
    self.presenter = presenter
  }
}
