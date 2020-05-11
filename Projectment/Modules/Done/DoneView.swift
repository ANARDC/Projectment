//
//  DoneView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct DonePreview: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }

  struct ContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<DonePreview.ContainerView>) -> UIViewController {
      DoneViewController()
    }

    func updateUIViewController(_ uiViewController: DonePreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DonePreview.ContainerView>) { }
  }
}

import UIKit

final class DoneViewController: BaseTasksViewController, DoneViewProtocol {
  
  // MARK: properties
  var configurator : DoneConfiguratorProtocol!
  var presenter    : DoneViewPresenterProtocol!
}

// MARK: - Life Cycle

extension DoneViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = DoneConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - UI Making

extension DoneViewController: DoneUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "Done"
  }
}
