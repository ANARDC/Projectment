//
//  DataService.swift
//  Projectment
//
//  Created by Anar on 11.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import Realm

final class DataService {
  func saveTeammate(for data: Teammate) {
    
  }
  
  private var tasks: [Task]? {
    [Task(id: "1",
          title: "Make login screen design",
          description: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .toDo,
          type: .design,
          complexity: .easy),
     Task(id: "2",
          title: "Configure GitHub",
          description: "Delegate to head of development team configuring github for remote control versions of the product",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .toDo,
          type: .development,
          complexity: .middle),
     Task(id: "3",
          title: "Make login screen design",
          description: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .toDo,
          type: .management,
          complexity: .hard),
     Task(id: "4",
          title: "Configure GitHub",
          description: "Delegate to head of development team configuring github for remote control versions of the product",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .inProgress,
          type: .planning,
          complexity: .easy),
     Task(id: "5",
          title: "Make login screen design",
          description: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .inProgress,
          type: .testing,
          complexity: .easy),
     Task(id: "6",
          title: "Configure GitHub",
          description: "Delegate to head of development team configuring github for remote control versions of the product",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .done,
          type: .development,
          complexity: .easy),
     Task(id: "7",
          title: "Make login screen design",
          description: "Discuss with designers and development team all the details of the login screen and the date and complete the task",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .done,
          type: .design,
          complexity: .easy),
     Task(id: "8",
          title: "Configure GitHub",
          description: "Delegate to head of development team configuring github for remote control versions of the product",
          who: self.team?.randomElement(),
          created: Date(),
          expires: Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay)),
          state: .toDo,
          type: .development,
          complexity: .easy)]
  }
  
  var team: [Teammate]? {
    [Teammate(id: "1",
              name: "Kevin",
              lastName: "Spacey",
              job: .designer,
              post: .middle),
     Teammate(id: "2",
              name: "Abraham",
              lastName: "Lincoln",
              job: .developer,
              post: .senior)]
  }
  
  var tasksIDList: [String]? {
    self.tasks?.map { $0.id }
  }
  
  var teammatesIDList: [String]? {
    self.team?.map { $0.id }
  }
  
  var toDoTasks: [Task]? {
    self.tasks?.filter { $0.state == .toDo }
  }
  
  var inProgressTasks: [Task]? {
    self.tasks?.filter { $0.state == .inProgress }
  }
  
  var doneTasks: [Task]? {
    self.tasks?.filter { $0.state == .done }
  }
}
