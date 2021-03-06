//
//  UIButton.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UIButton {
  convenience init(closure: (UIButton) -> ()) {
    self.init()
    closure(self)
  }
}
