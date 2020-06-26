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
      InProgressViewController(context: TasksContext.shared, style: .grouped)
    }

    func updateUIViewController(_ uiViewController: InProgressPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<InProgressPreview.ContainerView>) { }
  }
}


import UIKit

final class InProgressViewController: BaseEntityTableViewController<TasksContext, Task>, InProgressViewProtocol {
  
  // MARK: properties
  var configurator : InProgressConfiguratorProtocol!
  var presenter    : InProgressViewPresenterProtocol!
}

// MARK: - Life Cycle

extension InProgressViewController {
  override func viewWillAppear(_ animated: Bool) {
    self.presenter.viewWillAppear()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.generalDelegate = self
    super.tasksContextDelegate = self
    self.configurator = InProgressConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

extension InProgressViewController: BaseEntityTableViewControllerDelegate {
  func deleteEntity(with id: String?) {
    self.presenter.deleteTask(with: id)
  }
  
  func addEntityButton() {
    self.presenter.addTaskButton()
  }
}

extension InProgressViewController: BaseEntityTableViewControllerTasksContextDelegate {
  var screen: Screen {
    .inProgress
  }
  
  func moveTaskToToDo(with id: String?) {
    self.presenter.moveTaskToToDo(with: id)
  }
  
  func moveTaskToInProgress(with id: String?) {
    self.presenter.moveTaskToInProgress(with: id)
  }
  
  func moveTaskToDone(with id: String?) {
    self.presenter.moveTaskToDone(with: id)
  }
  
  func showTeamListButton() {
    self.presenter.showTeamListButton()
  }
  
  func whoButton(with id: String?) {
    self.presenter.whoButton(with: id)
  }
  
  func dateButton(with id: String?) {
    self.presenter.dateButton(with: id)
  }
}

// MARK: - Data

extension InProgressViewController: InProgressViewDataProtocol {
  func setTasks(for tasks: [Task]?) {
    super.entities = tasks
  }
}

// MARK: - UI Making

extension InProgressViewController: InProgressUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "In Progress"
  }
  
  func makeTabBar() {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  func makeTeammateInfoView(for teammate: Teammate?) {
    let alert = UIAlertController(title: "\(teammate?.name ?? "") \(teammate?.lastName ?? "")", message: "ID: \(teammate?.id ?? "")\nJob: \(teammate?.job ?? "")\nPost: \(teammate?.post ?? "")", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func makeDateInfoView(for created: Date?, _ expires: Date?) {
    var alert: UIAlertController
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss dd.MM.yyyy EEEE"
    
    guard let createdDate = created else { return }
    
    if let expiresDate = expires {
      alert = UIAlertController(title: "Dates", message: "Created: \(formatter.string(from: createdDate))\nExpires: \(formatter.string(from: expiresDate))", preferredStyle: UIAlertController.Style.alert)
    } else {
      alert = UIAlertController(title: "Dates", message: "Created: \(formatter.string(from: createdDate))\nExpires: Never", preferredStyle: UIAlertController.Style.alert)
    }
    
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
