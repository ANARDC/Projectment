//
//  UIPickerView.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UIPickerView {
  convenience init(closure: (UIPickerView) -> ()) {
    self.init()
    closure(self)
  }
}
