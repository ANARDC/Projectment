//
//  InProgressView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct InProgressPreview: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }

  struct ContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<InProgressPreview.ContainerView>) -> UIViewController {
      InProgressViewController()
    }

    func updateUIViewController(_ uiViewController: InProgressPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<InProgressPreview.ContainerView>) { }
  }
}


import UIKit

final class InProgressViewController: BaseTasksViewController, InProgressViewProtocol {
  
  // MARK: properties
  var configurator : InProgressConfiguratorProtocol!
  var presenter    : InProgressViewPresenterProtocol!
}

// MARK: - Life Cycle

extension InProgressViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = InProgressConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - UI Making

extension InProgressViewController: InProgressUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "In Progress"
  }
}
