//
//  AddTeammateInteractor.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

final class AddTeammateInteractor: AddTeammateInteractorProtocol {
  
  // MARK: properties
  weak var presenter : AddTeammateInteractorPresenterProtocol!
  var dataService    : DataService
  
  init(_ presenter: AddTeammateInteractorPresenterProtocol, _ dataService: DataService) {
    self.presenter   = presenter
    self.dataService = dataService
  }
  
  func saveTeammate(for data: Teammate) -> Observable<RealmOperationState> {
    self.dataService.saveTeammate(for: data)
  }
  
  var teammatesIDList: [String]? {
    self.dataService.teammatesIDList
  }
}
