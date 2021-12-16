//
//  ComplexViewController.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import UIKit
import Then
import ReactorKit
import RxSwift
import RxCocoa
import Reusable
import RxDataSources
import SnapKit

class ComplexViewController: BaseViewController, ReactorKit.View {
  
  // MARK: UI
  private let myTableView = UITableView().then {
    $0.register(cellType: MessageTableViewCell.self)
    $0.register(cellType: PhotoTableViewCell.self)
    $0.rowHeight = UITableView.automaticDimension
  }
  
  private static func configureCollectionViewCell(
    tableView: UITableView,
    indexPath: IndexPath,
    item: ComplexSection.MyItem
  ) -> UITableViewCell {
    switch item {
    case .message(let message):
      let cell = tableView.dequeueReusableCell(for: indexPath) as MessageTableViewCell
      cell.setMessage(message)
      return cell
    case .photo(let photo):
      let cell = tableView.dequeueReusableCell(for: indexPath) as PhotoTableViewCell
      cell.setPhoto(photo)
      return cell
    }
  }
  
  // MARK: Initializers
  required init(reactor: ComplexViewReactor) {
    defer { self.reactor = reactor }
    super.init()
  }
  
  override func configureLayout() {
    self.view.addSubview(myTableView)
    
    self.myTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func bind(reactor: ComplexViewReactor) {
    // Action
    self.rx.viewDidLoad
      .map { Reactor.Action.viewDidLoad }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    // State
    let dataSource = RxTableViewSectionedReloadDataSource<ComplexSection.Model> { dataSource, tableView, indexPath, item in
      Self.configureCollectionViewCell(
        tableView: tableView,
        indexPath: indexPath,
        item: item
      )
    }
    
    dataSource.titleForHeaderInSection = { dataSource, index in
      let section = dataSource.sectionModels[index].model
      switch section {
      case .message:
        return "Message Section"
      case .image:
        return "Image Section"
      }
    }
    
    reactor.state.map { [$0.messageSection, $0.imageSection] }
      .distinctUntilChanged()
      .bind(to: self.myTableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
  }
}
