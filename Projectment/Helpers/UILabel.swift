//
//  UILabel.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UILabel {
  convenience init(superview: UIView, configuring: (UILabel) -> (), constraints: (UILabel) -> ()) {
    self.init()
    configuring(self)
    self.translatesAutoresizingMaskIntoConstraints = false
    superview.addSubview(self)
    constraints(self)
  }
}
