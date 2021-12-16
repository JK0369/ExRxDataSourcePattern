//
//  MultiSection.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import RxDataSources

struct MultiSection {
  typealias MessageSectionModel = SectionModel<MessageSection, MessageItem>
  
  enum MessageSection: Equatable {
    case main
    case sub
  }
  
  enum MessageItem: Equatable {
    case firstItem(Message)
  }
}
