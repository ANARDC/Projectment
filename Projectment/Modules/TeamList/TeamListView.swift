//
//  TeamListView.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class TeamListViewController: UIViewController, TeamListViewProtocol {
  
  // MARK: properties
  var configurator : TeamListConfiguratorProtocol!
  var presenter    : TeamListViewPresenterProtocol!
}

// MARK: - Life Cycle

extension TeamListViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = TeamListConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - UI Making

extension TeamListViewController: TeamListUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "Team List"
  }
}
