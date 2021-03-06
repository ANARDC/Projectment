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
    self.setup()
    self.configure()
  }

  private func setup() {
    let toDoViewController  = UINavigationController.make(for: ToDoViewController(context: TasksContext.shared, style: .grouped),
                                                          selected: UIImage(systemName: "rectangle.stack.fill")!,
                                                          unselected: UIImage(systemName: "rectangle.stack")!)
    let inProgressViewController = UINavigationController.make(for: InProgressViewController(context: TasksContext.shared, style: .grouped),
                                                               selected: UIImage(systemName: "chart.bar.fill")!,
                                                               unselected: UIImage(systemName: "chart.bar")!)
    let doneViewController = UINavigationController.make(for: DoneViewController(context: TasksContext.shared, style: .grouped),
                                                         selected: UIImage(systemName: "checkmark.circle.fill")!,
                                                         unselected: UIImage(systemName: "checkmark.circle")!)

    self.viewControllers = [toDoViewController, inProgressViewController, doneViewController]
  }
  
  private func configure() {
    self.tabBar.barTintColor            = .purple
    self.tabBar.tintColor               = .white
    self.tabBar.unselectedItemTintColor = .white
    self.tabBar.layer.masksToBounds     = true
    self.tabBar.isTranslucent           = true
    self.tabBar.barStyle                = .black
    self.tabBar.layer.cornerRadius      = 40
    self.tabBar.layer.maskedCorners     = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
}
