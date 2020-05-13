//
//  TaskComplexity.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

enum TaskComplexity: String, CaseIterable {
  case easy
  case middle
  case hard
  case unknown
  
  var icon: UIImage? {
    switch self {
    case .easy:
      return UIImage(systemName: "hare.fill")
    case .middle:
      return UIImage(systemName: "ant.fill")
    case .hard:
      return UIImage(systemName: "tortoise.fill")
    case .unknown:
      return UIImage(systemName: "questionmark")
    }
  }
}
