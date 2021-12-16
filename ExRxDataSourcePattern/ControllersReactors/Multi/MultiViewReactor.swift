//
//  MultiViewReactor.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import ReactorKit
import RxCocoa

final class MultiViewReactor: Reactor {
  enum Action {
    case viewDidLoad
  }
  
  enum Mutation {
    case updateDataSource
  }
  
  struct State {
    var messageSection = MultiSection.MessageSectionModel(
      model: .main,
      items: []
    )
  }
  
  var initialState = State()
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
      return Observable<Mutation>.just(.updateDataSource)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .updateDataSource:
      let messages = getMessageMock()
      let myItems = messages.map(MultiSection.MessageItem.firstItem)
      let mySectionModel = MultiSection.MessageSectionModel(model: .main, items: myItems)
      state.messageSection = mySectionModel
    }
    return state
  }
}

