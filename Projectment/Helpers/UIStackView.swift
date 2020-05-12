//
//  UIStackView.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UIStackView {
  convenience init(arrangedSubviews: [UIView], closure: (UIStackView) -> ()) {
    self.init(arrangedSubviews: arrangedSubviews)
    closure(self)
  }
}
