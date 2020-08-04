//
//  UIStackView.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UIStackView {
  convenience init(superview: UIView, arrangedSubviews: [UIView], configuring: (UIStackView) -> (), constraints: (UIStackView) -> ()) {
    self.init(arrangedSubviews: arrangedSubviews)
    configuring(self)
    self.translatesAutoresizingMaskIntoConstraints = false
    superview.addSubview(self)
    constraints(self)
  }
}

