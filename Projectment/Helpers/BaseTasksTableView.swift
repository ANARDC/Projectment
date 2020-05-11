//
//  BaseTasksTableView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

//import UIKit
//
//final class BaseTasksTableView: UITableView {
//  let cellID = "cellID"
//  var tasks: [Task]? {
//    didSet {
//      self.reloadData()
//    }
//  }
//
//  override func numberOfRows(inSection section: Int) -> Int {
//    print(self.tasks?.count)
//    return self.tasks?.count ?? 0
//  }
//
//  override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
//    let cell = self.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? BaseTasksTableViewCell
//    return cell
//  }
//}
