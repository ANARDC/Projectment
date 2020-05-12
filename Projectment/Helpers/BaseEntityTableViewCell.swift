//
//  BaseEntityTableViewCell.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SnapKit

final class BaseEntityTableViewCell<Context: Contextable, Entity: Entitiable>: UITableViewCell {
  var entity: Entity?
  
  func setup(with entity: Entity?) {
    self.entity = entity
  }
}

extension BaseEntityTableViewCell where Context == TasksContext, Entity == Task {
  func make() {
    self.textLabel?.text = self.entity?.title
  }
}
