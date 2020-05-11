//
//  ToDoView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct ToDoPreview: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }

  struct ContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ToDoPreview.ContainerView>) -> UIViewController {
      ToDoViewController()
    }

    func updateUIViewController(_ uiViewController: ToDoPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ToDoPreview.ContainerView>) { }
  }
}

import UIKit
final class ToDoViewController: BaseTasksViewController, ToDoViewProtocol {
  
  // MARK: properties
  var configurator : ToDoConfiguratorProtocol!
  var presenter    : ToDoViewPresenterProtocol!
  
//  override init(with tasks: [Task]? = nil) {
//    super.init(with: [Task(id: "1",
//                           title: "First Task",
//                           created: Date(),
//                           state: .toDo,
//                           type: .development,
//                           weight: .easy)])
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
}

// MARK: - Life Cycle

extension ToDoViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = ToDoConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

// MARK: - UI Making

extension ToDoViewController: ToDoUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "To Do"
  }
}


