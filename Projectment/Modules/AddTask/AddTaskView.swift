//
//  AddTaskView.swift
//  Projectment
//
//  Created by Anar on 12.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AddTaskViewController: UIViewController, AddTaskViewProtocol {
  
  // MARK: properties
  var configurator : AddTaskConfiguratorProtocol!
  var presenter    : AddTaskViewPresenterProtocol!
  
  var team: [Teammate]?
  
  var titleTextField                      : CustomTextField?
  var descriptionTextView                 : UITextView?
  var whoPickerView                       : UIPickerView?
  var expiresPickerView                   : UIPickerView?
  var stateAndTypeAndComplexityPickerView : UIPickerView?
  var addTaskButton                       : UIButton?
  
  var bag = DisposeBag()
}

// MARK: - Life Cycle

extension AddTaskViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = AddTaskConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    self.presenter.traitCollectionDidChange()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.view.endEditing(true)
  }
}

// MARK: - Reactive

extension AddTaskViewController: AddTaskViewReactive {
  func bindTitleSubscriber() {
    self.titleTextField?.rx.text
      .subscribeOn(SerialDispatchQueueScheduler(qos: .userInteractive))
      .ignoreNil()
      .subscribe(self.presenter.input.title)
      .disposed(by: self.bag)
  }
  
  func bindDescriptionSubscriber() {
    self.descriptionTextView?.rx.text
      .subscribe(self.presenter.input.taskDescription)
      .disposed(by: self.bag)
  }
  
  func bindWhoSubscriber() {
    self.whoPickerView?.rx.itemSelected
      .filter { _ in (self.team?.count ?? 0) > 0 }
      .map { self.team?[$0.row].id }
      .subscribe(self.presenter.input.teammateID)
      .disposed(by: self.bag)
  }
  
  func bindExpiresSubscriber() {
    self.expiresPickerView?.rx.itemSelected
      .map({
        switch $0.row {
        case 1:
          return Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInHour))
        case 2:
          return Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInDay))
        case 3:
          return Date(timeIntervalSinceNow: .init(TimeService<Int>.secondsInWeek))
        default:
          return nil
        }
      })
      .subscribe(self.presenter.input.expires)
      .disposed(by: self.bag)
  }
  
  func bindStateSubscriber() {
    self.stateAndTypeAndComplexityPickerView?.rx.itemSelected
      .filter { $0.component == 0 }
      .map { TaskState.allCases[$0.row] }
      .subscribe(self.presenter.input.state)
      .disposed(by: self.bag)
  }
  
  func bindTypeSubscriber() {
    self.stateAndTypeAndComplexityPickerView?.rx.itemSelected
      .filter { $0.component == 1 }
      .map { TaskType.allCases[$0.row] }
      .subscribe(self.presenter.input.type)
      .disposed(by: self.bag)
  }
  
  func bindComplexitySubscriber() {
    self.stateAndTypeAndComplexityPickerView?.rx.itemSelected
      .filter { $0.component == 2 }
      .map { TaskComplexity.allCases[$0.row] }
      .subscribe(self.presenter.input.complexity)
      .disposed(by: self.bag)
  }
  
  func bindAddTaskButtonSubscriber() {
    self.addTaskButton?.rx.tap
      .subscribe(self.presenter.input.addButton)
      .disposed(by: self.bag)
  }
}

// MARK: - Data

extension AddTaskViewController {
  func setTeam(for data: [Teammate]?) {
    self.team = data
  }
}

// MARK: - UI Making

extension AddTaskViewController: AddTaskUIProtocol {
  func changeTheme() {
    self.view.backgroundColor = self.view.traitCollection.userInterfaceStyle == .light ? .white : .black
    self.titleTextField?.layer.borderColor = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
    self.descriptionTextView?.layer.borderColor = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
  }
  
  func makeView() {
    self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? .white : .black
  }
  
  func makeNavBar() {
    self.navigationItem.title = "Add Task"
  }
  
  func makeTabBar() {
    self.tabBarController?.tabBar.isHidden = true
  }
  
  func makeTitleTextField() {
    self.titleTextField = CustomTextField() {
      $0.layer.borderColor  = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
      $0.layer.borderWidth  = 3
      $0.layer.cornerRadius = 25
      $0.font               = .systemFont(ofSize: 18)
      $0.placeholder        = "Title"
    }
    
    guard let titleTextField = self.titleTextField else { return }
    
    self.view.addSubview(titleTextField)
    
    titleTextField.snp.makeConstraints { maker in
      maker.top.equalTo((self.navigationController?.navigationBar.frame.maxY ?? 0) + 10)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(50)
    }
  }
  
  func makeDescriptionTextView() {
    self.descriptionTextView = UITextView() {
      $0.layer.borderColor  = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
      $0.layer.borderWidth  = 3
      $0.layer.cornerRadius = 25
      $0.font               = .systemFont(ofSize: 15)
      $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    guard let descriptionTextView = self.descriptionTextView, let titleTextField = self.titleTextField else { return }
    
    self.view.addSubview(descriptionTextView)
    
    descriptionTextView.snp.makeConstraints { maker in
      maker.top.equalTo(titleTextField.snp.bottom).offset(10)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(100)
    }
  }
  
  func makeWhoPickerView() {
    self.whoPickerView = UIPickerView() {
      $0.delegate   = self
      $0.dataSource = self
    }
    
    guard let whoPickerView = whoPickerView, let descriptionTextView = self.descriptionTextView else { return }
    
    self.view.addSubview(whoPickerView)
    
    whoPickerView.snp.makeConstraints { maker in
      maker.top.equalTo(descriptionTextView.snp.bottom).offset(5)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(100)
    }
  }
  
  func makeExpiresPickerView() {
    self.expiresPickerView = UIPickerView {
      $0.delegate   = self
      $0.dataSource = self
    }
    
    guard let expiresPickerView = self.expiresPickerView, let whoPickerView = self.whoPickerView else { return }
    
    self.view.addSubview(expiresPickerView)
    
    expiresPickerView.snp.makeConstraints { maker in
      maker.top.equalTo(whoPickerView.snp.bottom).offset(5)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(100)
    }
  }
  
  func makeStateAndTypeAndComplexityPickerView() {
    self.stateAndTypeAndComplexityPickerView = UIPickerView {
      $0.delegate   = self
      $0.dataSource = self
    }
    
    guard let stateAndTypeAndComplexityPickerView = self.stateAndTypeAndComplexityPickerView, let expiresPickerView = self.expiresPickerView else { return }
    
    self.view.addSubview(stateAndTypeAndComplexityPickerView)
    
    stateAndTypeAndComplexityPickerView.snp.makeConstraints { maker in
      maker.top.equalTo(expiresPickerView.snp.bottom).offset(5)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(100)
    }
  }
  
  func makeAddTaskButton() {
    self.addTaskButton = UIButton() {
      $0.backgroundColor = .purple
      $0.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
      $0.setTitle("Add", for: .normal)
      $0.layer.cornerRadius = 25
    }
    
    guard let addTaskButton = self.addTaskButton, let stateAndTypeAndComplexityPickerView = self.stateAndTypeAndComplexityPickerView else { return }
    
    self.view.addSubview(addTaskButton)
    
    addTaskButton.snp.makeConstraints { maker in
      maker.top.equalTo(stateAndTypeAndComplexityPickerView.snp.bottom).offset(5)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(50)
    }
  }
  
  func changeAddTaskButton(isValid: Bool) {
    self.addTaskButton?.backgroundColor = isValid ? self.addTaskButton?.backgroundColor?.withAlphaComponent(1) : self.addTaskButton?.backgroundColor?.withAlphaComponent(0.6)
    
    let titleColor = isValid ? UIColor.white.withAlphaComponent(1) : UIColor.white.withAlphaComponent(0.6)
      
    self.addTaskButton?.setTitleColor(titleColor, for: .normal)
    self.addTaskButton?.isEnabled = isValid
  }
}

extension AddTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    switch pickerView {
    case self.whoPickerView:
      return 1
    case self.expiresPickerView:
      return 1
    case self.stateAndTypeAndComplexityPickerView:
      return 3
    default:
      return 0
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch pickerView {
    case self.whoPickerView:
      return self.team?.count ?? 0
    case self.expiresPickerView:
      return 4
    case self.stateAndTypeAndComplexityPickerView:
      switch component {
      case 0:
        return TaskState.allCases.count
      case 1:
        return TaskType.allCases.count
      case 2:
        return TaskComplexity.allCases.count
      default:
        return 0
      }
    default:
      return 0
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch pickerView {
    case self.whoPickerView:
      return "ID: \(self.team?[row].id ?? "##") Name: \((self.team?[row].name ?? "UnknownName") + (self.team?[row].lastName ?? "UnknownLastName"))"
    case self.expiresPickerView:
      switch row {
      case 0:
        return "Never"
      case 1:
        return "One hour"
      case 2:
        return "One day"
      case 3:
        return "One week"
      default:
        return nil
      }
    case self.stateAndTypeAndComplexityPickerView:
      switch component {
      case 0:
        return TaskState.allCases[row].rawValue.capitalized
      case 1:
        return TaskType.allCases[row].rawValue.capitalized
      case 2:
        return TaskComplexity.allCases[row].rawValue.capitalized
      default:
        return nil
      }
    default:
      return nil
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    35
  }
}
