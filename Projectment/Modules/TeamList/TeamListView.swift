//
//  TeamListView.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class TeamListViewController: BaseEntityTableViewController<TeamContext, Teammate>, TeamListViewProtocol {
  
  // MARK: properties
  var configurator : TeamListConfiguratorProtocol!
  var presenter    : TeamListViewPresenterProtocol!
}

// MARK: - Life Cycle

extension TeamListViewController {
  override func viewWillAppear(_ animated: Bool) {
    self.presenter.viewWillAppear()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.generalDelegate = self
    self.configurator = TeamListConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - Data

extension TeamListViewController: TeamListViewDataProtocol {
  func setTeam(for team: [Teammate]?) {
    super.entities = team
  }
}

extension TeamListViewController: BaseEntityTableViewControllerDelegate {
  func deleteEntity(with id: String?) {
    self.presenter.deleteTeammate(with: id)
  }
  
  func addEntityButton() {
    self.presenter.goToAddTeammateScreen()
  }
}

// MARK: - UI Making

extension TeamListViewController: TeamListUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "Team List"
  }
  
  func makeTabBar() {
    self.tabBarController?.tabBar.isHidden = true
  }
}
