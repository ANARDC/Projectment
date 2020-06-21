//
//  AddTaskPresenter.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

final class AddTaskPresenter: AddTaskPresenterGeneralProtocol {
  
  // MARK: properties
  
  weak var view           : AddTaskUIProtocol!
  internal var interactor : AddTaskInteractorProtocol!
  internal var router     : AddTaskRouterProtocol!
  
  var input  : AddTaskInput
  var output : AddTaskOutput
  
  var team: [Teammate]?
  
  var bag = DisposeBag()
  
  init(_ view: AddTaskUIProtocol, _ input: AddTaskInput, _ output: AddTaskOutput) {
    self.view   = view
    self.input  = input
    self.output = output
  }
}

// MARK: - View Life Cycle

extension AddTaskPresenter: AddTaskLifeCyclePresenterProtocol {
  func viewDidLoad() {
    self.team = self.interactor.team
    self.makeView()
    self.makeReactive()
    self.bindReactive()
  }
  
  func viewWillAppear() {
    self.view.makeTabBar()
  }
  
  func traitCollectionDidChange() {
    self.view.changeTheme()
  }
}

private extension AddTaskPresenter {
  func makeView() {
    self.view.setTeam(for: self.team)
    self.view.makeView()
    self.view.makeNavBar()
    self.view.makeTitleTextField()
    self.view.makeDescriptionTextView()
    self.view.makeWhoPickerView()
    self.view.makeExpiresPickerView()
    self.view.makeStateAndTypeAndComplexityPickerView()
    self.view.makeAddTaskButton()
  }
  
  func makeReactive() {
    self.makeTitleAndWhoSubscriber()
    self.makeAddTaskButtonSubscriber()
    self.makeDataValidationSubscriber()
  }
  
  func bindReactive() {
    self.view.bindTitleSubscriber()
    self.view.bindDescriptionSubscriber()
    self.view.bindWhoSubscriber()
    self.view.bindExpiresSubscriber()
    self.view.bindStateSubscriber()
    self.view.bindTypeSubscriber()
    self.view.bindComplexitySubscriber()
    self.view.bindAddTaskButtonSubscriber()
  }
}

private extension AddTaskPresenter {
  var taskObservable: Observable<Task> {
    Observable
      .combineLatest(self.input.title,
                     self.input.taskDescription,
                     self.input.teammateID.startWith(self.team?.first?.id),
                     self.input.expires.startWith(nil),
                     self.input.state.startWith(.toDo),
                     self.input.type.startWith(.design),
                     self.input.complexity.startWith(.easy)) { title, taskDescription, teammateID, expires, state, type, complexity in
                      Task(id: UUID().uuidString,
                           title: title,
                           taskDescription: taskDescription,
                           teammateID: teammateID,
                           expires: expires,
                           state: state.rawValue,
                           type: type.rawValue,
                           complexity: complexity.rawValue)
    }
  }
  
  func makeTitleAndWhoSubscriber() {
    Observable.combineLatest(self.input.title, self.input.teammateID.startWith(self.team?.first?.id))
      .subscribe(onNext: { title, who in
        let titleIsValid = !title.isEmpty
        let whoIsValid   = !(who == nil)
        self.output.dataIsValid.onNext(titleIsValid && whoIsValid)
      })
      .disposed(by: self.bag)
  }
  
  func makeAddTaskButtonSubscriber() {
    self.input.addButton
      .withLatestFrom(self.taskObservable)
      .flatMapLatest { self.interactor.saveTask(for: $0).materialize() }
      .subscribe(onNext: { event in
        switch event {
        case .next(let state):
          switch state {
          case .success:
            dump("Success Saving")
          case .error:
            fatalError("Saving Data Cannot Be Done")
          }
        case .error(let error):
          fatalError(error.localizedDescription)
        case .completed:
          self.router.back(from: self.view)
        }
      })
      .disposed(by: self.bag)
  }
  
  func makeDataValidationSubscriber() {
    self.output.dataIsValid
      .subscribe(onNext: { dataIsValid in
        self.view.changeAddTaskButton(isValid: dataIsValid)
      })
      .disposed(by: self.bag)
  }
}
