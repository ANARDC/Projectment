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
      DoneViewController(context: TasksContext.shared, style: .grouped)
    }

    func updateUIViewController(_ uiViewController: DonePreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DonePreview.ContainerView>) { }
  }
}

import UIKit

final class DoneViewController: BaseEntityTableViewController<TasksContext, Task>, DoneViewProtocol {
  // MARK: properties
  var configurator : DoneConfiguratorProtocol!
  var presenter    : DoneViewPresenterProtocol!
}

// MARK: - Life Cycle

extension DoneViewController {
  override func viewWillAppear(_ animated: Bool) {
    self.presenter.viewWillAppear()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.generalDelegate = self
    super.tasksContextDelegate = self
    self.configurator = DoneConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

extension DoneViewController: BaseEntityTableViewControllerDelegate {
  func deleteEntity(with id: String?) {
    self.presenter.deleteTask(with: id)
  }
  
  func addEntityButton() {
    self.presenter.addTaskButton()
  }
}

extension DoneViewController: BaseEntityTableViewControllerTasksContextDelegate {
  func showTeamListButton() {
    self.presenter.showTeamListButton()
  }
}

// MARK: - Data

extension DoneViewController: DoneViewDataProtocol {
  func setTasks(for tasks: [Task]?) {
    super.entities = tasks
  }
}

// MARK: - UI Making

extension DoneViewController: DoneUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "Done"
  }
  
  func makeTabBar() {
    self.tabBarController?.tabBar.isHidden = false
  }
}
