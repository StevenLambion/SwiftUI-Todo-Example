import Foundation
import SwiftDux

final class AppReducer : Reducer {
  
  let mainSceneReducer = MainSceneReducer()
  let todoListsReducer = TodoListsReducer()
  
  func reduceNext(state: AppState, action: Action) -> AppState {
    return AppState(
      mainScene: mainSceneReducer.reduceAny(state: state.mainScene, action: action),
      todoLists: todoListsReducer.reduceAny(state: state.todoLists, action: action)
    )
  }
  
}
