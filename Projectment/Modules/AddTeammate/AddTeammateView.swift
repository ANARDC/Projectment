//
//  AddTeammateView.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class AddTeammateViewController: UIViewController, AddTeammateViewProtocol {
  
  // MARK: properties
  var configurator : AddTeammateConfiguratorProtocol!
  var presenter    : AddTeammateViewPresenterProtocol!
}

// MARK: - Life Cycle

extension AddTeammateViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = AddTeammateConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - UI Making

extension AddTeammateViewController: AddTeammateUIProtocol {
  func makeView() {
    self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? .white : .black
  }
  
  func makeNavBar() {
    self.navigationItem.title = "Add Teammate"
  }
}
