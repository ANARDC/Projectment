//
//  UIImageView.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

extension UIImageView {
  convenience init(image: UIImage?, closure: (UIImageView) -> ()) {
    self.init(image: image)
    closure(self)
  }
}
