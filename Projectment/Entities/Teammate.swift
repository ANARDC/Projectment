//
//  Teammate.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import Unrealm

struct Teammate: Realmable, Entitiable {
  var id       : String = UUID().uuidString
  var name     : String = ""
  var lastName : String?
  var job      : Job = .designer
  var post     : Post = .junior
  
  static func primaryKey() -> String? { "id" }
}
