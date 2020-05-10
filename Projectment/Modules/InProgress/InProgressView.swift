//
//  InProgressView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class InProgressViewController: BaseTasksViewController, InProgressViewProtocol {
  
  // MARK: properties
  var configurator : InProgressConfiguratorProtocol!
  var presenter    : InProgressViewPresenterProtocol!
}

// MARK: - Life Cycle

extension InProgressViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = InProgressConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - UI Making

extension InProgressViewController: InProgressUIProtocol {
  
}
