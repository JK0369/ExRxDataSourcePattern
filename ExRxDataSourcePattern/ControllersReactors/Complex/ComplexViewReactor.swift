//
//  ComplexViewReactor.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import ReactorKit
import RxCocoa

final class ComplexViewReactor: Reactor {
  enum Action {
    case viewDidLoad
  }
  
  enum Mutation {
    case setPhotos
    case setMessages
  }
  
  struct State {
    var messageSection = ComplexSection.Model(
      model: .message,
      items: []
    )
    var imageSection = ComplexSection.Model(
      model: .image,
      items: []
    )
  }
  
  var initialState = State()
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
      return .concat(
        [Observable<Mutation>.just(.setMessages),
         Observable<Mutation>.just(.setPhotos)
        ]
      )
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .setMessages:
      let messages = getMessageMock()
      let myItems = messages.map(ComplexSection.MyItem.message)
      let mySectionModel = ComplexSection.Model(model: .message, items: myItems)
      state.messageSection = mySectionModel
    case .setPhotos:
      let photo = UIImage(named: "snow")
      let myItems = ComplexSection.MyItem.photo(photo)
      let mySectionModel = ComplexSection.Model(model: .image, items: [myItems])
      state.imageSection = mySectionModel
    }
    return state
  }
}

