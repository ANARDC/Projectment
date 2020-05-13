//
//  AddTeammatePresenter.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import RxSwift

final class AddTeammatePresenter: AddTeammatePresenterGeneralProtocol {
  
  // MARK: properties
  
  weak var view           : AddTeammateUIProtocol!
  internal var interactor : AddTeammateInteractorProtocol!
  internal var router     : AddTeammateRouterProtocol!
  
  var input  : AddTeammateInput
  var output : AddTeammateOutput
  
  var bag = DisposeBag()
  
  init(_ view: AddTeammateUIProtocol, _ input: AddTeammateInput, _ output: AddTeammateOutput) {
    self.view   = view
    self.input  = input
    self.output = output
  }
}

// MARK: - View Life Cycle

extension AddTeammatePresenter: AddTeammateLifeCyclePresenterProtocol {
  func viewDidLoad() {
    self.makeView()
    self.makeReactive()
    self.bindReactive()
  }
  
  func traitCollectionDidChange() {
    self.view.changeTheme()
  }
}

private extension AddTeammatePresenter {
  func makeView() {
    self.view.makeView()
    self.view.makeNavBar()
    self.view.makeNameTextField()
    self.view.makeLastNameTextField()
    self.view.makeIDTextField()
    self.view.makeJobAndPostPickerView()
    self.view.makeAddTeammateButton()
  }
  
  func makeReactive() {
    self.makeNameAndIDSubscriber()
    self.makeAddTeammateButtonSubscriber()
  }
  
  func bindReactive() {
    self.view.bindNameSubscriber()
    self.view.bindLastNameSubscriber()
    self.view.bindIDSubscriber()
    self.view.bindJobSubcriber()
    self.view.bindPostSubcriber()
    self.view.bindAddTeammateButtonSubscriber()
  }
}

private extension AddTeammatePresenter {
  var teammateObservable: Observable<Teammate> {
    Observable
      .combineLatest(self.input.id, self.input.name, self.input.lastName, self.input.job.startWith(.designer), self.input.post.startWith(.junior)) { id, name, lastName, job, post in
        Teammate(id: id,
                 name: name,
                 lastName: lastName,
                 job: job.rawValue,
                 post: post.rawValue)
    }
  }
  
  func makeNameAndIDSubscriber() {
    Observable
      .combineLatest(self.input.name, self.input.id)
      .subscribe(onNext: { name, id in
        let nameIsValid = !name.isEmpty
        let idIsValid   = !(id.isEmpty || (self.interactor.teammatesIDList?.contains(id) ?? false))
        self.view.changeAddTeammateButton(isValid: nameIsValid && idIsValid)
      })
      .disposed(by: self.bag)
  }
  
  func makeAddTeammateButtonSubscriber() {
    self.input.addButton
      .withLatestFrom(self.teammateObservable)
      .flatMapLatest({ teammate in
        self.interactor.saveTeammate(for: teammate).materialize()
      })
      .subscribe(onNext: { event in
        print("asdasd")
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
}
