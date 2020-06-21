//
//  TeamContext.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

struct TeamContext: Contextable {
  static var shared = TeamContext(info: ContextInfo(name: "Team Context",
                                                    description: "Interaction with team members",
                                                    scenesCount: 1))
  
  var info: ContextInfo
}
