//
//  AddTaskView.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class AddTaskViewController: UIViewController, AddTaskViewProtocol {
  
  // MARK: properties
  var configurator : AddTaskConfiguratorProtocol!
  var presenter    : AddTaskViewPresenterProtocol!
}

// MARK: - Life Cycle

extension AddTaskViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = AddTaskConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    self.presenter.traitCollectionDidChange()
  }
}

// MARK: - UI Making

extension AddTaskViewController: AddTaskUIProtocol {
  func makeView() {
    self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? .white : .black
  }
  
  func makeNavBar() {
    self.navigationItem.title = "Add Task"
  }
}
