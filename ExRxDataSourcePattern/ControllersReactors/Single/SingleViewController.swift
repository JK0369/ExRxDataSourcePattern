//
//  SingleViewController.swift
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

class SingleViewController: BaseViewController, ReactorKit.View {
  
  // MARK: UI
  private let myTableView = UITableView().then {
    $0.register(cellType: MessageTableViewCell.self)
    $0.rowHeight = 72.0
  }
  
  private let nextButton = UIButton().then {
    $0.setTitle("다음", for: .normal)
    $0.setTitleColor(.systemBlue, for: .normal)
    $0.setTitleColor(.blue, for: .highlighted)
  }
  
  private static func configureCollectionViewCell(
    tableView: UITableView,
    indexPath: IndexPath,
    item: SingleSection.MessageItem
  ) -> UITableViewCell {
    switch item {
    case .firstItem(let message):
      let cell = tableView.dequeueReusableCell(for: indexPath) as MessageTableViewCell
      cell.setMessage(message)
      return cell
    }
  }
  
  // MARK: Initializers
  required init(reactor: SingleViewReactor) {
    defer { self.reactor = reactor }
    super.init()
  }
  
  override func configureLayout() {
    self.view.addSubview(myTableView)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
    
    self.myTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func bind(reactor: SingleViewReactor) {
    // Action
    self.rx.viewDidLoad
      .map { Reactor.Action.viewDidLoad }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    nextButton.rx.tap
      .bind { [weak self] in
        let reactor = MultiViewReactor()
        let viewController = MultiViewController(reactor: reactor)
        self?.navigationController?.pushViewController(viewController, animated: true)
      }
      .disposed(by: disposeBag)
    
    // State
    let dataSource = RxTableViewSectionedReloadDataSource<SingleSection.MessageSectionModel> { dataSource, tableView, indexPath, item in
      Self.configureCollectionViewCell(
        tableView: tableView,
        indexPath: indexPath,
        item: item
      )
    }
  
    reactor.state.map(\.messageSection)
      .distinctUntilChanged()
      .map(Array.init(with:))
      .bind(to: self.myTableView.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
  }
}
