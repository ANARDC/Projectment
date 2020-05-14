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
  var screen: Screen {
    .done
  }
  
  func showTeamListButton() {
    self.presenter.showTeamListButton()
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
  
  func whoButton(with id: String?) {
    self.presenter.whoButton(with: id)
  }
  
  func dateButton(with id: String?) {
    self.presenter.dateButton(with: id)
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
  
  func makeTeammateInfoView(for teammate: Teammate?) {
    let alert = UIAlertController(title: "\(teammate?.name ?? "") \(teammate?.lastName ?? "")", message: "ID: \(teammate?.id ?? "")\nJob: \(teammate?.job ?? "")\nPost: \(teammate?.post ?? "")", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func makeDateInfoView(for dates: (Date?, Date?)) {
    var alert: UIAlertController
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss dd.MM.yyyy EEEE"
    
    guard let createdDate = dates.0 else { return }
    
    if let expiresDate = dates.1 {
      alert = UIAlertController(title: "Dates", message: "Created: \(formatter.string(from: createdDate))\nExpires: \(formatter.string(from: expiresDate))", preferredStyle: UIAlertController.Style.alert)
    } else {
      alert = UIAlertController(title: "Dates", message: "Created: \(formatter.string(from: createdDate))\nExpires: Never", preferredStyle: UIAlertController.Style.alert)
    }
    
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
