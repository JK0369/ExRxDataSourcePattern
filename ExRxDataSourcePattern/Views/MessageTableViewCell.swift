//
//  MessageTableViewCell.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import UIKit
import Reusable
import SnapKit

final class MessageTableViewCell: UITableViewCell, Reusable {
  // MARK: Constants
  private enum Metric {
    static let componentPadding = 8.0
  }
  
  // MARK: UI
  private let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.font = UIFont.systemFont(ofSize: 22)
  }
  
  private let supplementLabel = UILabel().then {
    $0.textColor = .systemBlue
  }
  
  // MARK: Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(supplementLabel)
    
    self.titleLabel.snp.makeConstraints {
      $0.top.left.right.equalToSuperview().inset(Metric.componentPadding)
    }
    self.supplementLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.componentPadding)
      $0.left.right.bottom.equalToSuperview().inset(Metric.componentPadding)
    }
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setMessage(_ message: Message) {
    titleLabel.text = message.title
    supplementLabel.text = message.supplement
  }
}
