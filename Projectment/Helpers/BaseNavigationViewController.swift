//
// Created by Anar on 10.05.2020.
// Copyright (c) 2020 Anar. All rights reserved.
//

import UIKit

final class BaseNavigationViewController: UINavigationController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
}

extension UINavigationController {
  static func make(for viewController: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
    let navigationController = BaseNavigationViewController(rootViewController: viewController)
    
    navigationController.tabBarItem.image                 = unselected
    navigationController.tabBarItem.selectedImage         = selected
    navigationController.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
    
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.titleTextAttributes                    = [.foregroundColor: UIColor.white]
      navBarAppearance.largeTitleTextAttributes               = [.foregroundColor: UIColor.white]
      navBarAppearance.backgroundColor                        = .purple
      navigationController.navigationBar.standardAppearance   = navBarAppearance
      navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    navigationController.navigationBar.prefersLargeTitles = true
    
    return navigationController
  }
}

