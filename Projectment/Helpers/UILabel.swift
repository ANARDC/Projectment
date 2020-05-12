//
//  UILabel.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UILabel {
  convenience init(closure: (UILabel) -> ()) {
    self.init()
    closure(self)
  }
}
