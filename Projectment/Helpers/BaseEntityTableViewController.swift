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
}

@objc protocol BaseEntityTableViewControllerTasksContextDelegate {
  func showTeammateListButton()
}

class BaseEntityTableViewController<Context: Contextable, Entity: Entitiable>: UITableViewController {
  var generalDelegate      : BaseEntityTableViewControllerDelegate? {
    didSet {
      self.makeAddEntityButton()
      if type(of: self.context) == TasksContext.self {
        self.makeShowTeammateListButton()
      }
      self.addNavBarButtons()
    }
  }
  var tasksContextDelegate : BaseEntityTableViewControllerTasksContextDelegate? {
    didSet {
      self.makeAddEntityButton()
      if type(of: self.context) == TasksContext.self {
        self.makeShowTeammateListButton()
      }
      self.addNavBarButtons()
    }
  }
  
  var context: Context
  
  var addEntityButton        : UIBarButtonItem!
  var showTeammateListButton : UIBarButtonItem?
  
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
    self.makeAddEntityButton()
    if type(of: self.context) == TasksContext.self {
      self.makeShowTeammateListButton()
    }
    self.addNavBarButtons()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.entities?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if type(of: self.context) == TasksContext.self {
      if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? BaseEntityTableViewCell<TasksContext, Task>, let task = self.entities?[indexPath.row] as? Task {
        cell.setup(with: task)
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
  
  func makeShowTeammateListButton() {
    var showTeammateListButton: UIBarButtonItem
    
    if let tasksContextDelegate = self.tasksContextDelegate {
      showTeammateListButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack.person.crop"), style: .done, target: self, action: #selector(tasksContextDelegate.showTeammateListButton))
    } else {
      showTeammateListButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack.person.crop"), style: .done, target: self, action: nil)
    }
    
    showTeammateListButton.tintColor = .white
    self.showTeammateListButton = showTeammateListButton
  }
  
  func addNavBarButtons() {
    if let showTeammateListButton = self.showTeammateListButton {
      self.navigationItem.rightBarButtonItems = [self.addEntityButton, showTeammateListButton]
    } else {
      self.navigationItem.rightBarButtonItems = [self.addEntityButton]
    }
  }
}
