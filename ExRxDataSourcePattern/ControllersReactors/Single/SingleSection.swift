//
//  SingleSection.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import RxDataSources

struct SingleSection {
  typealias MessageSectionModel = SectionModel<Int, MessageItem>
  
  enum MessageItem: Equatable {
    case firstItem(Message)
  }
}
