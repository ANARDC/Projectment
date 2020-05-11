//
//  BaseTasksViewController.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SnapKit

class BaseTasksViewController: UITableViewController {
  var cellID = "cellID"
  
  var tasks: [Task]? {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.makeTasksTableView()
  }
  
}

private extension BaseTasksViewController {
  func makeTasksTableView() {
    self.tableView.register(BaseTasksTableViewCell.self, forCellReuseIdentifier: self.cellID)
  }
}

extension BaseTasksViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(self.tasks?.count)
    return self.tasks?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! BaseTasksTableViewCell
    cell.textLabel?.text = self.tasks?[indexPath.row].title
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight
  }
}
