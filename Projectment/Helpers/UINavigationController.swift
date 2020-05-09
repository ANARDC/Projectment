//
// Created by Anar on 10.05.2020.
// Copyright (c) 2020 Anar. All rights reserved.
//

import UIKit

extension UINavigationController {
  static func make(for viewController: UIViewController, selected: UIImage, unselected: UIImage, title: String) -> UINavigationController {
    let navigationController = self.init(rootViewController: viewController)

    navigationController.tabBarItem.image                 = unselected
    navigationController.tabBarItem.selectedImage         = selected
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.navigationItem.title             = title

    return navigationController
  }
}
