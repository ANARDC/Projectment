//
//  Contextable.swift
//  Projectment
//
//  Created by Anar on 11.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

protocol Contextable {
  associatedtype ContextInfoType
  
  var info: ContextInfoType { get set }
}
