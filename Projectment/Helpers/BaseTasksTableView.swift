//
//  BaseTasksTableView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class BaseTasksTableView: UITableView {
  let cellID = "cellID"
  var tasks: [Task]?
  
  init(with tasks: [Task]? = nil, frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    self.tasks = tasks
    self.register(BaseTasksTableViewCell.self, forCellReuseIdentifier: self.cellID)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func numberOfRows(inSection section: Int) -> Int {
    self.tasks?.count ?? 0
  }
  
  override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
    let cell = self.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? BaseTasksTableViewCell
    return cell
  }
}
