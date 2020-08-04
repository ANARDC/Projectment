//
//  BaseEntityTableViewController.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

@objc protocol BaseEntityTableViewControllerDelegate {
  func addEntityButton()
  func deleteEntity(with id: String?)
}

protocol BaseEntityTableViewControllerTasksContextDelegate: BaseEntityTableViewControllerSelectors {
  var screen: Screen { get }
  
  
  func changeTaskState(with id: String?, to state: TaskState)
//  func moveTaskToToDo(with id: String?)
//  func moveTaskToInProgress(with id: String?)
//  func moveTaskToDone(with id: String?)
  func whoButton(with: String?)
  func dateButton(with: String?)
}

@objc protocol BaseEntityTableViewControllerSelectors {
  func showTeamListButton()
}

class BaseEntityTableViewController<Context: Contextable, Entity: Entitiable>: UITableViewController {
  var generalDelegate: BaseEntityTableViewControllerDelegate? {
    didSet {
      self.makeAddEntityButton()
      if type(of: self.context) == TasksContext.self {
        self.makeShowTeamListButton()
      }
      self.addNavBarButtons()
    }
  }
  
  var tasksContextDelegate: BaseEntityTableViewControllerTasksContextDelegate? {
    didSet {
      self.makeAddEntityButton()
      if type(of: self.context) == TasksContext.self {
        self.makeShowTeamListButton()
      }
      self.addNavBarButtons()
    }
  }
  
  var context: Context
  
  var addEntityButton    : UIBarButtonItem!
  var showTeamListButton : UIBarButtonItem?
  
  init(context: Context, style: UITableView.Style) {
    self.context = context
    super.init(style: style)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var cellID = "cellID"
  
  var entities: [Entity]? {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    self.tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.makeTasksTableView()
  }
  
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    UISwipeActionsConfiguration(actions: [self.makeContextualDeleteAction(for: indexPath)])
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    if type(of: self.context) == TasksContext.self {
      return UISwipeActionsConfiguration(actions: self.makeContextualActions(for: indexPath, from: self.tasksContextDelegate?.screen))
    } else {
      return nil
    }
  }
  
  func makeContextualDeleteAction(for indexPath: IndexPath) -> UIContextualAction {
    let entityID = self.entities?[indexPath.row].id
    
    let action = UIContextualAction(style: .normal, title: nil) { [unowned self] action, view, completion in
      self.entities?.remove(at: indexPath.row)
      self.generalDelegate?.deleteEntity(with: entityID)
      
      completion(true)
    }
    
    action.image = UIImage(systemName: "multiply.circle.fill")
    action.backgroundColor = .red
    
    return action
  }
  
  func makeContextualActions(for indexPath: IndexPath, from screen: Screen?) -> [UIContextualAction] {
    let entityID = self.entities?[indexPath.row].id
    
    let movetoToDo = UIContextualAction(style: .normal, title: nil) { [unowned self] action, view, completion in
      self.entities?.remove(at: indexPath.row)
      self.tasksContextDelegate?.changeTaskState(with: entityID, to: .toDo)

      completion(true)
    }
    
    movetoToDo.image = UIImage(systemName: "rectangle.stack.fill")
    movetoToDo.backgroundColor = .purple
    
    let movetoInProgress = UIContextualAction(style: .normal, title: nil) { [unowned self] action, view, completion in
      self.entities?.remove(at: indexPath.row)
      self.tasksContextDelegate?.changeTaskState(with: entityID, to: .inProgress)

      completion(true)
    }
    
    movetoInProgress.image = UIImage(systemName: "chart.bar.fill")
    movetoInProgress.backgroundColor = .purple
    
    let movetoDone = UIContextualAction(style: .normal, title: nil) { [unowned self] action, view, completion in
      self.entities?.remove(at: indexPath.row)
      self.tasksContextDelegate?.changeTaskState(with: entityID, to: .done)
      
      completion(true)
    }
    
    movetoDone.image = UIImage(systemName: "checkmark.circle.fill")
    movetoDone.backgroundColor = .purple
    
    switch screen {
    case .toDo:
      return [movetoDone, movetoInProgress]
    case .inProgress:
      return [movetoDone, movetoToDo]
    case .done:
      return [movetoInProgress, movetoToDo]
    default:
      return []
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.entities?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if type(of: self.context) == TasksContext.self {
      if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? BaseEntityTableViewCell<TasksContext, Task>, let task = self.entities?[indexPath.row] as? Task {
        cell.setup(with: task, delegate: self.tasksContextDelegate)
        cell.make()
        return cell
      }
    } else if type(of: self.context) == TeamContext.self {
      if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? BaseEntityTableViewCell<TeamContext, Teammate>, let teammate = self.entities?[indexPath.row] as? Teammate {
        cell.setup(with: teammate)
        cell.make()
        return cell
      }
    }
    
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight
  }
}

private extension BaseEntityTableViewController {
  func makeTasksTableView() {
    self.tableView.register(BaseEntityTableViewCell<Context, Entity>.self, forCellReuseIdentifier: self.cellID)
  }
  
  func makeAddEntityButton() {
    var addEntityButton: UIBarButtonItem
    
    if let generalDelegate = self.generalDelegate {
      addEntityButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(generalDelegate.addEntityButton))
    } else {
      addEntityButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: nil)
    }
    
    addEntityButton.tintColor = .white
    self.addEntityButton = addEntityButton
  }
  
  func makeShowTeamListButton() {
    var showTeamListButton: UIBarButtonItem
    
    if let tasksContextDelegate = self.tasksContextDelegate {
      showTeamListButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack.person.crop"), style: .done, target: self, action: #selector(tasksContextDelegate.showTeamListButton))
    } else {
      showTeamListButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack.person.crop"), style: .done, target: self, action: nil)
    }
    
    showTeamListButton.tintColor = .white
    self.showTeamListButton = showTeamListButton
  }
  
  func addNavBarButtons() {
    if let showTeamListButton = self.showTeamListButton {
      self.navigationItem.rightBarButtonItems = [self.addEntityButton, showTeamListButton]
    } else {
      self.navigationItem.rightBarButtonItems = [self.addEntityButton]
    }
  }
}
