//
//  TeamListInteractor.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

final class TeamListInteractor: TeamListInteractorProtocol {
  
  // MARK: properties
  weak var presenter : TeamListInteractorPresenterProtocol!
  var dataService    : DataService
  
  init(_ presenter: TeamListInteractorPresenterProtocol, _ dataService: DataService) {
    self.presenter   = presenter
    self.dataService = dataService
  }
  
  var team: [Teammate]? {
    self.dataService.team
  }
  
  func deleteTeammate(with id: String?) {
    self.dataService.delete(entityType: Teammate.self, entityID: id)
  }
}
