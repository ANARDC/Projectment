//
//  AddTeammateView.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SnapKit
import RxSwift
import RxCocoa

final class AddTeammateViewController: UIViewController, AddTeammateViewProtocol {
  
  // MARK: properties
  var configurator : AddTeammateConfiguratorProtocol!
  var presenter    : AddTeammateViewPresenterProtocol!
  
  var nameTextField        : CustomTextField?
  var lastNameTextField    : CustomTextField?
  var idTextField          : CustomTextField?
  var jobAndPostPickerView : UIPickerView?
  var addTeammateButton    : UIButton?
  
  var bag = DisposeBag()
}

// MARK: - Life Cycle

extension AddTeammateViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = AddTeammateConfigurator(self)
    self.configurator.configure(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.viewDidLoad()
//    self.navigationItem.largeTitleDisplayMode = .never
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

extension AddTeammateViewController {
  func bindNameSubscriber() {
    self.nameTextField?.rx.text
      .subscribeOn(SerialDispatchQueueScheduler(qos: .userInteractive))
      .ignoreNil()
      .subscribe(self.presenter.input.name)
      .disposed(by: self.bag)
  }
  
  func bindLastNameSubscriber() {
    self.lastNameTextField?.rx.text
      .subscribeOn(SerialDispatchQueueScheduler(qos: .userInteractive))
      .ignoreNil()
      .subscribe(self.presenter.input.lastName)
      .disposed(by: self.bag)
  }
  
  func bindIDSubscriber() {
    self.idTextField?.rx.text
      .subscribeOn(SerialDispatchQueueScheduler(qos: .userInteractive))
      .ignoreNil()
      .subscribe(self.presenter.input.id)
      .disposed(by: self.bag)
  }
  
  func bindJobSubcriber() {
    self.jobAndPostPickerView?.rx.itemSelected
      .filter { $0.component == 0 }
      .map { Job.allCases[$0.row] }
      .subscribe(self.presenter.input.job)
      .disposed(by: self.bag)
  }
  
  func bindPostSubcriber() {
    self.jobAndPostPickerView?.rx.itemSelected
      .filter { $0.component == 1 }
      .map { TeammatePost.allCases[$0.row] }
      .subscribe(self.presenter.input.post)
      .disposed(by: self.bag)
  }
  
  func bindAddTeammateButtonSubscriber() {
    self.addTeammateButton?.rx.tap
      .subscribe(self.presenter.input.addButton)
      .disposed(by: self.bag)
  }
}

// MARK: - UI Making

extension AddTeammateViewController: AddTeammateUIProtocol {
  func changeTheme() {
    let themeIsLight = self.view.traitCollection.userInterfaceStyle == .light
    
    self.view.backgroundColor                 = themeIsLight ? .white : .black
    self.nameTextField?.layer.borderColor     = themeIsLight ? UIColor.purple.cgColor : UIColor.white.cgColor
    self.lastNameTextField?.layer.borderColor = themeIsLight ? UIColor.purple.cgColor : UIColor.white.cgColor
    self.idTextField?.layer.borderColor       = themeIsLight ? UIColor.purple.cgColor : UIColor.white.cgColor
  }
  
  func makeView() {
    self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? .white : .black
  }
  
  func makeNavBar() {
    self.navigationItem.title = "Add Teammate"
  }
  
  func makeNameTextField() {
    self.nameTextField = CustomTextField() {
      $0.layer.borderColor  = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
      $0.layer.borderWidth  = 3
      $0.layer.cornerRadius = 25
      $0.font               = .systemFont(ofSize: 18)
      $0.placeholder        = "Name"
    }
    
    guard let nameTextField = self.nameTextField else { return }
    
    self.view.addSubview(nameTextField)
    
    nameTextField.snp.makeConstraints { maker in
      maker.top.equalTo(160)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(50)
    }
  }
  
  func makeLastNameTextField() {
    self.lastNameTextField = CustomTextField() {
      $0.layer.borderColor  = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
      $0.layer.borderWidth  = 3
      $0.layer.cornerRadius = 25
      $0.font               = .systemFont(ofSize: 18)
      $0.placeholder        = "Last name (optional)"
    }
    
    guard let lastNameTextField = self.lastNameTextField, let nameTextField = self.nameTextField else { return }
    
    self.view.addSubview(lastNameTextField)
    
    lastNameTextField.snp.makeConstraints { maker in
      maker.top.equalTo(nameTextField.snp.bottom).offset(20)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(50)
    }
  }
  
  func makeIDTextField() {
    self.idTextField = CustomTextField() {
      $0.layer.borderColor  = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
      $0.layer.borderWidth  = 3
      $0.layer.cornerRadius = 25
      $0.font               = .systemFont(ofSize: 18)
      $0.placeholder        = "ID"
      $0.keyboardType       = .numberPad
    }
    
    guard let idTextField = self.idTextField, let lastNameTextField = self.lastNameTextField else { return }
    
    self.view.addSubview(idTextField)
    
    idTextField.snp.makeConstraints { maker in
      maker.top.equalTo(lastNameTextField.snp.bottom).offset(20)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(50)
    }
  }
  
  func makeJobAndPostPickerView() {
    self.jobAndPostPickerView = UIPickerView() {
      $0.delegate   = self
      $0.dataSource = self
    }
    
    guard let jobAndPostPickerView = self.jobAndPostPickerView, let idTextField = self.idTextField else { return }
    
    self.view.addSubview(jobAndPostPickerView)
    
    jobAndPostPickerView.snp.makeConstraints { maker in
      maker.top.equalTo(idTextField.snp.bottom).offset(20)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(200)
    }
  }
  
  func makeAddTeammateButton() {
    self.addTeammateButton = UIButton() {
      $0.backgroundColor = .purple
      $0.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
      $0.setTitle("Add", for: .normal)
      $0.layer.cornerRadius = 25
    }
    
    guard let addTeammateButton = self.addTeammateButton else { return }
    
    self.view.addSubview(addTeammateButton)
    
    addTeammateButton.snp.makeConstraints { maker in
      maker.bottom.equalTo(-40)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(50)
    }
  }
  
  func changeAddTeammateButton(isValid: Bool) {
    self.addTeammateButton?.backgroundColor = isValid ? self.addTeammateButton?.backgroundColor?.withAlphaComponent(1) : self.addTeammateButton?.backgroundColor?.withAlphaComponent(0.6)
    
    let titleColor = isValid ? UIColor.white.withAlphaComponent(1) : UIColor.white.withAlphaComponent(0.6)
      
    self.addTeammateButton?.setTitleColor(titleColor, for: .normal)
    self.addTeammateButton?.isEnabled = isValid
   }
}

extension AddTeammateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    2
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
      return Job.allCases.count
    case 1:
      return TeammatePost.allCases.count
    default:
      return 0
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch component {
    case 0:
      return Job.allCases[row].rawValue.capitalized
    case 1:
      return TeammatePost.allCases[row].rawValue.capitalized
    default:
      return nil
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    35
  }
}
