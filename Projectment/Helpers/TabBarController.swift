//
// Created by Anar on 09.05.2020.
// Copyright (c) 2020 Anar. All rights reserved.
//

import SwiftUI
@available(iOS 13, *)
struct TabBarPreview: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  
  struct ContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarPreview.ContainerView>) -> UIViewController {
      TabBarController()
    }
    
    func updateUIViewController(_ uiViewController: TabBarPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarPreview.ContainerView>) { }
  }
}

import UIKit

final class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 13.0, *) {
      self.setup()
    }
  }

  @available(iOS 13.0, *)
  private func setup() {
    let toDoViewController  = UINavigationController.make(for: ToDoViewController(),
                                                          selected: UIImage(systemName: "rectangle.stack.fill")!,
                                                          unselected: UIImage(systemName: "rectangle.stack")!)
    let inProgressViewController = UINavigationController.make(for: InProgressViewController(),
                                                               selected: UIImage(systemName: "hourglass.tophalf.fill")!,
                                                               unselected: UIImage(systemName: "hourglass")!)
    let doneViewController = UINavigationController.make(for: DoneViewController(),
                                                         selected: UIImage(systemName: "checkmark.circle.fill")!,
                                                         unselected: UIImage(systemName: "checkmark.circle")!)

    self.viewControllers = [toDoViewController, inProgressViewController, doneViewController]
    
    self.tabBar.backgroundColor     = UIColor.purple.withAlphaComponent(0.8)
    self.tabBar.tintColor           = UIColor.yellow.withAlphaComponent(0.9)
    self.tabBar.layer.masksToBounds = true
    self.tabBar.isTranslucent       = true
    self.tabBar.barStyle            = .blackOpaque
    self.tabBar.layer.cornerRadius  = 40
    self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
}
