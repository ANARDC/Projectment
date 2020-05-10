//
//  ToDoInteractor.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

final class ToDoInteractor: ToDoInteractorProtocol {
  
  // MARK: properties
  weak var presenter: ToDoInteractorPresenterProtocol!
  
  init(_ presenter: ToDoInteractorPresenterProtocol) {
    self.presenter = presenter
  }
}
