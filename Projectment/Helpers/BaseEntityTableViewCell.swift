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
    self.subviews.forEach { $0.removeFromSuperview() }
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
    self.taskTitleLabel = UILabel(
      superview: self,
      configuring: { label in
        label.text          = self.entity?.title
        label.font          = .systemFont(ofSize: 18)
        label.numberOfLines = 1
      },
      constraints: { label in
        label.snp.makeConstraints { maker in
          maker.top.leading.equalTo(10)
        }
      }
    )
  }
  
  func makeDescriptionLabel() {
    self.taskDescriptionLabel = UILabel(
      superview: self,
      configuring: { label in
        label.text          = self.entity?.taskDescription
        label.font          = .systemFont(ofSize: 13)
        label.textColor     = .darkGray
        label.numberOfLines = 3
      },
      constraints: { label in
        guard let titleLabel = self.taskTitleLabel else { return }
        
        label.snp.makeConstraints { maker in
          maker.top.equalTo(titleLabel.snp.bottom).offset(5)
          maker.left.equalTo(10)
          maker.bottom.right.equalTo(-10)
        }
      }
    )
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
    self.taskTypeIcon = UIImageView(image: self.entity?.type.icon) {
      $0.tintColor   = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .purple : .white
      $0.contentMode = .scaleAspectFit
      
      $0.snp.makeConstraints {
        $0.width.height.equalTo(20)
        
        /* SnapKit swearing for some reason ¯\_(ツ)_/¯
         *
         * switch TaskType(rawValue: self.entity?.type ?? "unknown") {
         * case .design, .planning, .unknown:
         *   $0.width.height.equalTo(20)
         * case .development, .testing:
         *   $0.width.height.equalTo(25)
         * case .management:
         *   $0.width.height.equalTo(30)
         * case .none:
         *   return
         * }
         */
      }
    }
  }
  
  func makeWeightIcon() {
    self.taskComplexityIcon = UIImageView(image: self.entity?.complexity.icon) {
      $0.tintColor   = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .purple : .white
      $0.contentMode = .scaleAspectFit
      
      $0.snp.makeConstraints {
        $0.width.height.equalTo(20)
        
        /* SnapKit swearing for some reason ¯\_(ツ)_/¯
         *
         * switch TaskComplexity(rawValue: self.entity?.complexity ?? "unknown") {
         * case .easy, .middle, .unknown:
         * $0.width.height.equalTo(20)
         * case .hard:
         * $0.width.height.equalTo(25)
         * case .none:
         * return
         * }
         */
      }
    }
  }
  
  func makeStackView() {
    self.taskIconsStackView = UIStackView(
      superview: self,
      arrangedSubviews: [self.taskWhoButton, self.taskDateButton, self.taskTypeIcon, self.taskComplexityIcon].compactMap { $0 },
      configuring: { stackView in
        stackView.axis    = .horizontal
        stackView.spacing = 10
      },
      constraints: { stackView in
        stackView.snp.makeConstraints { maker in
          guard let titleLabel = self.taskTitleLabel else { return }
          
          maker.right.equalTo(-10)
          maker.left.equalTo(titleLabel.snp.right).offset(20)
          maker.centerY.equalTo(titleLabel)
        }
      }
    )
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
    self.teammateIDLabel = UILabel(
      superview: self,
      configuring: { label in
        label.text          = "ID: \(self.entity?.id ?? "###")"
        label.font          = .systemFont(ofSize: 10)
        label.textColor     = .darkGray
        label.numberOfLines = 1
      },
      constraints: { label in
        label.snp.makeConstraints { maker in
          maker.bottom.right.equalTo(-10)
        }
      }
    )
  }
  
  func makeTeammateNameLabel() {
    self.teammateNameLabel = UILabel(
      superview: self,
      configuring: { label in
        label.text          = "\(self.entity?.name ?? "UnknownName") \(self.entity?.lastName ?? "UnknownLastName")"
        label.font          = .systemFont(ofSize: 18)
        label.numberOfLines = 1
      },
      constraints: { label in
        label.snp.makeConstraints { maker in
          maker.left.equalTo(10)
          maker.top.equalTo(5)
        }
      }
    )
  }
  
  func makeTeammateJobLabel() {
    self.teammateJobLabel = UILabel(
      superview: self,
      configuring: { label in
        label.text          = "Job: \(self.entity?.job.rawValue.capitalized ?? "Unknown")"
        label.font          = .systemFont(ofSize: 14)
        label.numberOfLines = 1
      },
      constraints: { label in
        guard let teammateNameLabel = self.teammateNameLabel else { return }
        
        label.snp.makeConstraints { maker in
          maker.left.equalTo(10)
          maker.top.equalTo(teammateNameLabel.snp.bottom).offset(5)
        }
      }
    )
  }
  
  func makeTeammatePostLabel() {
    self.teammatePostLabel = UILabel(
      superview: self,
      configuring: { label in
        label.text          = "Post: \(self.entity?.post.rawValue.capitalized ?? "Unknown")"
        label.font          = .systemFont(ofSize: 14)
        label.numberOfLines = 1
      },
      constraints: { label in
        guard let teammateJobLabel = self.teammateJobLabel else { return }
        
        label.snp.makeConstraints { maker in
          maker.left.equalTo(10)
          maker.top.equalTo(teammateJobLabel.snp.bottom).offset(5)
          maker.bottom.equalTo(-5)
        }
      }
    )
  }
}
