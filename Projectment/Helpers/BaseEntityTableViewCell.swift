//
//  BaseEntityTableViewCell.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SnapKit

final class BaseEntityTableViewCell<Context: Contextable, Entity: Entitiable>: UITableViewCell {
  var entity   : Entity?
  var delegate : BaseEntityTableViewControllerTasksContextDelegate?
  
  // Task Context UI Elements
  
  var taskTitleLabel       : UILabel?
  var taskDescriptionLabel : UILabel?
  var taskWhoButton        : UIButton?
  var taskDateButton       : UIButton?
  var taskTypeIcon         : UIImageView?
  var taskComplexityIcon   : UIImageView?
  var taskIconsStackView   : UIStackView?
  
  // Team Context UI Elements
  
  var teammateIDLabel       : UILabel?
  var teammateNameLabel     : UILabel?
  var teammateLastNameLabel : UILabel?
  var teammateJobLabel      : UILabel?
  var teammatePostLabel     : UILabel?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.subviews.forEach({ $0.removeFromSuperview() })
  }
  
  @objc func callWhoButton() {
    self.delegate?.whoButton(with: self.entity?.id)
  }
  
  @objc func callDateButton() {
    self.delegate?.dateButton(with: self.entity?.id)
  }
}

extension BaseEntityTableViewCell where Context == TasksContext, Entity == Task {
  func setup(with entity: Entity?, delegate: BaseEntityTableViewControllerTasksContextDelegate?) {
    self.entity   = entity
    self.delegate = delegate
  }
  
  func make() {
    self.makeTitleLabel()
    self.makeDescriptionLabel()
    self.makeWhoButton()
    self.makeDateButton()
    self.makeTypeIcon()
    self.makeWeightIcon()
    self.makeStackView()
  }
  
  func makeTitleLabel() {
    self.taskTitleLabel = UILabel() {
      $0.text          = self.entity?.title
      $0.font          = .systemFont(ofSize: 18)
      $0.numberOfLines = 1
    }
    
    guard let titleLabel = self.taskTitleLabel else { return }
    
    self.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints({ maker in
      maker.top.leading.equalTo(10)
    })
  }
  
  func makeDescriptionLabel() {
    self.taskDescriptionLabel = UILabel() {
      $0.text          = self.entity?.taskDescription
      $0.font          = .systemFont(ofSize: 13)
      $0.textColor     = .darkGray
      $0.numberOfLines = 0
    }
    
    guard let descriptionLabel = self.taskDescriptionLabel, let titleLabel = self.taskTitleLabel else { return }
    
    self.addSubview(descriptionLabel)
    
    descriptionLabel.snp.makeConstraints { maker in
      maker.top.equalTo(titleLabel.snp.bottom).offset(5)
      maker.left.equalTo(10)
      maker.right.equalTo(-10)
      maker.bottom.equalTo(-10)
    }
  }
  
  func makeWhoButton() {
    self.taskWhoButton = UIButton() {
      $0.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
      $0.tintColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .purple : .white
      
      $0.addTarget(self, action: #selector(self.callWhoButton), for: .touchUpInside)
      
      $0.snp.makeConstraints {
        $0.width.height.equalTo(20)
      }
    }
  }
  
  func makeDateButton() {
    self.taskDateButton = UIButton() {
      $0.setImage(UIImage(systemName: "clock.fill"), for: .normal)
      $0.tintColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .purple : .white
      
      $0.addTarget(self, action: #selector(self.callDateButton), for: .touchUpInside)
      
      $0.snp.makeConstraints {
        $0.width.height.equalTo(20)
      }
    }
  }
  
  func makeTypeIcon() {
    self.taskTypeIcon = UIImageView(image: TaskType(rawValue: self.entity?.type ?? "unknown")?.icon) {
      $0.tintColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .purple : .white
      
      $0.snp.makeConstraints {
        switch TaskType(rawValue: self.entity?.type ?? "unknown") {
        case .design:
          $0.width.height.equalTo(20)
        case .management:
          $0.width.height.equalTo(30)
        case .development:
          $0.width.height.equalTo(25)
        case .planning:
          $0.width.height.equalTo(20)
        case .testing:
          $0.width.height.equalTo(25)
        case .unknown:
          $0.width.height.equalTo(20)
        case .none:
          return
        }
      }
    }
  }
  
  func makeWeightIcon() {
    self.taskComplexityIcon = UIImageView(image: TaskComplexity(rawValue: self.entity?.complexity ?? "unknown")? .icon) {
      $0.tintColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .purple : .white
      
      $0.snp.makeConstraints {
        switch TaskComplexity(rawValue: self.entity?.complexity ?? "unknown") {
        case .easy:
          $0.width.height.equalTo(20)
        case .middle:
          $0.width.height.equalTo(20)
        case .hard:
          $0.width.height.equalTo(25)
        case .unknown:
          $0.width.height.equalTo(20)
        case .none:
          return
        }
      }
    }
  }
  
  func makeStackView() {
    guard
      let whoButton  = self.taskWhoButton,
      let dateButton = self.taskDateButton,
      let typeIcon   = self.taskTypeIcon,
      let weightIcon = self.taskComplexityIcon
      else { return }
    
    self.taskIconsStackView = UIStackView(arrangedSubviews: [whoButton, dateButton, typeIcon, weightIcon]) {
      $0.axis    = .horizontal
      $0.spacing = 10
      
      self.addSubview($0)
      
      $0.snp.makeConstraints { maker in
        guard let titleLabel = self.taskTitleLabel else { return }
        
        maker.right.equalTo(-10)
        maker.left.equalTo(titleLabel.snp.right).offset(20)
        maker.centerY.equalTo(titleLabel.snp.centerY)
      }
    }
  }
}

extension BaseEntityTableViewCell where Context == TeamContext, Entity == Teammate {
  func setup(with entity: Entity?) {
    self.entity = entity
  }
  
  func make() {
    self.makeTeammateIDLabel()
    self.makeTeammateNameLabel()
    self.makeTeammateJobLabel()
    self.makeTeammatePostLabel()
  }
  
  func makeTeammateIDLabel() {
    self.teammateIDLabel = UILabel() {
      $0.text          = "ID: \(self.entity?.id ?? "###")"
      $0.font          = .systemFont(ofSize: 10)
      $0.textColor     = .darkGray
      $0.numberOfLines = 1
    }
    
    guard let teammateIDLabel = self.teammateIDLabel else { return }
    
    self.addSubview(teammateIDLabel)
    
    teammateIDLabel.snp.makeConstraints { $0.bottom.right.equalTo(-10) }
  }
  
  func makeTeammateNameLabel() {
    self.teammateNameLabel = UILabel() {
      $0.text          = "\(self.entity?.name ?? "UnknownName") \(self.entity?.lastName ?? "UnknownLastName")"
      $0.font          = .systemFont(ofSize: 18)
      $0.numberOfLines = 1
    }
    
    guard let teammateNameLabel = self.teammateNameLabel else { return }
    
    self.addSubview(teammateNameLabel)
    
    teammateNameLabel.snp.makeConstraints { $0.left.equalTo(10); $0.top.equalTo(5) }
  }
  
  func makeTeammateJobLabel() {
    self.teammateJobLabel = UILabel() {
      
      $0.text          = "Job: \(Job(rawValue: self.entity?.job ?? "designer")?.rawValue.capitalized ?? "Uncnown")"
      $0.font          = .systemFont(ofSize: 14)
      $0.numberOfLines = 1
    }
    
    guard let teammateJobLabel = self.teammateJobLabel, let teammateNameLabel = self.teammateNameLabel else { return }
    
    self.addSubview(teammateJobLabel)
    
    teammateJobLabel.snp.makeConstraints { maker in
      maker.left.equalTo(10)
      maker.top.equalTo(teammateNameLabel.snp.bottom).offset(5)
    }
  }
  
  func makeTeammatePostLabel() {
    self.teammatePostLabel = UILabel() {
      $0.text          = "Post: \(TeammatePost(rawValue: self.entity?.post ?? "junior")?.rawValue.capitalized ?? "Unknown")"
      $0.font          = .systemFont(ofSize: 14)
      $0.numberOfLines = 1
    }
    
    guard let teammatePostLabel = self.teammatePostLabel, let teammateJobLabel = self.teammateJobLabel else { return }
    
    self.addSubview(teammatePostLabel)
    
    teammatePostLabel.snp.makeConstraints { maker in
      maker.left.equalTo(10)
      maker.top.equalTo(teammateJobLabel.snp.bottom).offset(5)
      maker.bottom.equalTo(-5)
    }
  }
}
