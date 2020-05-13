//
//  AddTeammateView.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SnapKit

final class AddTeammateViewController: UIViewController, AddTeammateViewProtocol {
  
  // MARK: properties
  var configurator : AddTeammateConfiguratorProtocol!
  var presenter    : AddTeammateViewPresenterProtocol!
  
  var nameTextField        : CustomTextField?
  var lastNameTextField    : CustomTextField?
  var jobAndPostPickerView : UIPickerView?
  var addTeammateButton    : UIButton?
}

// MARK: - Life Cycle

extension AddTeammateViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = AddTeammateConfigurator(self)
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

// MARK: - UI Making

extension AddTeammateViewController: AddTeammateUIProtocol {
  func changeTheme() {
    self.view.backgroundColor = self.view.traitCollection.userInterfaceStyle == .light ? .white : .black
    self.nameTextField?.layer.borderColor = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
    self.lastNameTextField?.layer.borderColor = self.view.traitCollection.userInterfaceStyle == .light ? UIColor.purple.cgColor : UIColor.white.cgColor
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
      maker.top.equalTo((self.navigationController?.navigationBar.frame.maxY ?? 0) + 20)
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
      $0.placeholder        = "Last name"
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
  
  func makeJobAndPostPickerView() {
    self.jobAndPostPickerView = UIPickerView() {
      $0.delegate   = self
      $0.dataSource = self
    }
    
    guard let jobAndPostPickerView = self.jobAndPostPickerView, let lastNameTextField = self.lastNameTextField else { return }
    
    self.view.addSubview(jobAndPostPickerView)
    
    jobAndPostPickerView.snp.makeConstraints { maker in
      maker.top.equalTo(lastNameTextField.snp.bottom).offset(20)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(200)
    }
  }
  
  func makeAddTeammateButton() {
    self.addTeammateButton = UIButton() {
      $0.backgroundColor = self.view.traitCollection.userInterfaceStyle == .light ? .purple : .white
      $0.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
      $0.setTitle("Add", for: .normal)
      $0.layer.cornerRadius = 25
    }
    
    guard let addTeammateButton = self.addTeammateButton else { return }
    
    self.view.addSubview(addTeammateButton)
    
    addTeammateButton.snp.makeConstraints { maker in
      maker.bottom.equalTo(-(self.tabBarController?.tabBar.frame.size.height ?? 0) - 20)
      maker.left.equalTo(20)
      maker.right.equalTo(-20)
      maker.height.equalTo(50)
    }
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
