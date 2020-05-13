//
//  CustomTextField.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

final class CustomTextField: UITextField {
  
  let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  convenience init(closure: (CustomTextField) -> ()) {
    self.init()
    closure(self)
  }
}
