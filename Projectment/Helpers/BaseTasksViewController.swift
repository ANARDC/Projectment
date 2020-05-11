//
//  BaseTasksViewController.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SnapKit

class BaseTasksViewController: UITableViewController {
  var tasks: [Task]?
  
//  init(with tasks: [Task]? = nil) {
//    self.tasks = tasks
//    super.init(nibName: nil, bundle: nil)
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.makeTasksTableView()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight
  }
}

private extension BaseTasksViewController {
  func makeTasksTableView() {
    self.tableView = BaseTasksTableView(frame: self.view.frame, style: .plain)
  }
}
