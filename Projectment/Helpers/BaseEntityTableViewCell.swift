//
//  BaseEntityTableViewCell.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import SnapKit

final class BaseEntityTableViewCell<Context: Contextable, Entity: Entitiable>: UITableViewCell {
  var entity: Entity?
  
  var titleLabel       : UILabel?
  var descriptionLabel : UILabel?
  var whoButton        : UIButton?
  var dateButton       : UIButton?
  var typeIcon         : UIImageView?
  var weightIcon       : UIImageView?
  var stackView        : UIStackView?
  
  func setup(with entity: Entity?) {
    self.entity = entity
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.subviews.forEach({ $0.removeFromSuperview() })
  }
}

extension BaseEntityTableViewCell where Context == TasksContext, Entity == Task {
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
    self.titleLabel = UILabel() {
      $0.text          = self.entity?.title
      $0.font          = .systemFont(ofSize: 18)
      $0.numberOfLines = 1
    }
    
    guard let titleLabel = self.titleLabel else { return }
    
    self.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints({ maker in
      maker.top.leading.equalTo(10)
    })
  }
  
  func makeDescriptionLabel() {
    self.descriptionLabel = UILabel() {
      $0.text          = self.entity?.description
      $0.font          = .systemFont(ofSize: 13)
      $0.textColor     = .darkGray
      $0.numberOfLines = 0
    }
    
    guard let descriptionLabel = self.descriptionLabel, let titleLabel = self.titleLabel else { return }
    
    self.addSubview(descriptionLabel)
    
    descriptionLabel.snp.makeConstraints { maker in
      maker.top.equalTo(titleLabel.snp.bottom).offset(5)
      maker.left.equalTo(10)
      maker.right.equalTo(-10)
      maker.bottom.equalTo(-10)
    }
  }
  
  func makeWhoButton() {
    self.whoButton = UIButton() {
      $0.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
      $0.tintColor = .purple
      
      $0.snp.makeConstraints {
        $0.width.height.equalTo(20)
      }
    }
  }
  
  func makeDateButton() {
    self.dateButton = UIButton() {
      $0.setImage(UIImage(systemName: "clock.fill"), for: .normal)
      $0.tintColor = .purple
      
      $0.snp.makeConstraints {
        $0.width.height.equalTo(20)
      }
    }
  }
    
  func makeTypeIcon() {
    self.typeIcon = UIImageView(image: self.entity?.type.icon) {
      $0.tintColor = .purple
      
      $0.snp.makeConstraints {
        switch self.entity?.type {
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
        case .none:
          return
        }
      }
    }
  }
  
  func makeWeightIcon() {
    self.weightIcon = UIImageView(image: self.entity?.complexity.icon) {
      $0.tintColor = .purple
      
      $0.snp.makeConstraints {
        switch self.entity?.complexity {
        case .easy:
          $0.width.height.equalTo(20)
        case .middle:
          $0.width.height.equalTo(20)
        case .hard:
          $0.width.height.equalTo(25)
        case .none:
          return
        }
      }
    }
  }
  
  func makeStackView() {
    guard
      let whoButton  = self.whoButton,
      let dateButton = self.dateButton,
      let typeIcon   = self.typeIcon,
      let weightIcon = self.weightIcon
      else { return }
    
    self.stackView = UIStackView(arrangedSubviews: [whoButton, dateButton, typeIcon, weightIcon]) {
      $0.axis    = .horizontal
      $0.spacing = 10
      
      self.addSubview($0)
      
      $0.snp.makeConstraints { maker in
        guard let titleLabel = self.titleLabel else { return }
        
        maker.right.equalTo(-10)
        maker.left.equalTo(titleLabel.snp.right).offset(20)
        maker.centerY.equalTo(titleLabel.snp.centerY)
      }
    }
  }
}
