//
//  PhotoTableViewCell.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import UIKit
import Reusable
import SnapKit

final class PhotoTableViewCell: UITableViewCell, Reusable {
  // MARK: Constants
  private enum Metric {
    static let componentPadding = 8.0
  }
  
  // MARK: UI
  private let photoImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  
  // MARK: Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(photoImageView)
    
    self.photoImageView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(Metric.componentPadding)
    }
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setPhoto(_ photo: UIImage?) {
    self.photoImageView.image = photo
  }
}
