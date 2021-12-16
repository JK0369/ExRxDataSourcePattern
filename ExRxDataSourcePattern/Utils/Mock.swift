//
//  Mock.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import Foundation

func getMessageMock() -> [Message] {
  (1...3).map {
    Message(title: "title(\($0))", supplement: "supplement(\($0))")
  }
}
