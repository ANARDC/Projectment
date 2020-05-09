//
// Created by Anar on 09.05.2020.
// Copyright (c) 2020 Anar. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }

  private func setup() {
    self.viewControllers = []
  }
}
