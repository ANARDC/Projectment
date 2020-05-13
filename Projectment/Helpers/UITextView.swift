//
//  UITextView.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UITextView {
  convenience init(closure: (UITextView) -> ()) {
    self.init()
    closure(self)
  }
}
