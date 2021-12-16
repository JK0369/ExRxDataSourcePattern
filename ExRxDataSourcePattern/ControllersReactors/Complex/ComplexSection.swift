//
//  ComplexSection.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import RxDataSources

struct ComplexSection {
  typealias Model = SectionModel<MySection, MyItem>
  
  enum MySection: Equatable {
    case message
    case image
  }
  
  enum MyItem: Equatable {
    case message(Message)
    case photo(UIImage?)
  }
}
