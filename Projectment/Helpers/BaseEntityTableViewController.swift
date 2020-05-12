//
//  BaseEntityTableViewController.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

class BaseEntityTableViewController<Context: Contextable, Entity: Entitiable>: UITableViewController {
  var context: Context
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.makeTasksTableView()
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
}
