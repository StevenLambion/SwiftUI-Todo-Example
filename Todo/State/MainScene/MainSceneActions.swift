import Foundation
import SwiftDux

enum MainSceneAction: Action {
  case setDisplayMode(MainSceneDisplayMode)
}

extension MainSceneAction {
  
  static func updateDisplayMode(_ displayMode: MainSceneDisplayMode) -> ActionPlan<AppState> {
    return ActionPlan { store in
      store.send(MainSceneAction.setDisplayMode(displayMode))
      guard displayMode == .regular && store.state.selectedTodoListId == nil else { return }
      if let id = store.state.todoLists.first?.id {
        store.send(AppAction.selectTodoList(id: id))
      }
    }
  }
  
}
