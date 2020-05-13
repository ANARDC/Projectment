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
      ToDoViewController(context: TasksContext.shared, style: .grouped)
    }

    func updateUIViewController(_ uiViewController: ToDoPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ToDoPreview.ContainerView>) { }
  }
}

import UIKit

final class ToDoViewController: BaseEntityTableViewController<TasksContext, Task>, ToDoViewProtocol {
  // MARK: properties
  var configurator : ToDoConfiguratorProtocol!
  var presenter    : ToDoViewPresenterProtocol!
}

// MARK: - Life Cycle

extension ToDoViewController {
  override func viewWillAppear(_ animated: Bool) {
    self.presenter.viewWillAppear()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.generalDelegate = self
    super.tasksContextDelegate = self
    self.configurator = ToDoConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

extension ToDoViewController: BaseEntityTableViewControllerDelegate {
  func addEntityButton() {
    self.presenter.addTaskButton()
  }
}

extension ToDoViewController: BaseEntityTableViewControllerTasksContextDelegate {
  func showTeamListButton() {
    self.presenter.showTeamListButton()
  }
}

// MARK: - Data

extension ToDoViewController: ToDoViewDataProtocol {
  func setTasks(for tasks: [Task]?) {
    super.entities = tasks
  }
}

// MARK: - UI Making

extension ToDoViewController: ToDoUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "To Do"
  }
  
  func makeTabBar() {
    self.tabBarController?.tabBar.isHidden = false
  }
}
