//
//  DoneView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class DoneViewController: BaseTasksViewController, DoneViewProtocol {
  
  // MARK: properties
  var configurator : DoneConfiguratorProtocol!
  var presenter    : DoneViewPresenterProtocol!
}

// MARK: - Life Cycle

extension DoneViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = DoneConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - UI Making

extension DoneViewController: DoneUIProtocol {
  
}
