import Foundation
import SwiftDux

enum MainSceneAction: Action {
  case setDisplayMode(MainSceneDisplayMode)
  case selectList(byId: String?)
}

extension MainSceneAction {
  
  static func updateDisplayMode(_ displayMode: MainSceneDisplayMode) -> ActionPlan<AppState> {
    return ActionPlan { send, getState in
      let state = getState()
      send(MainSceneAction.setDisplayMode(displayMode))
      if displayMode == .regular && state.mainScene.selectedListId == nil {
        if let id = state.todoLists.first?.id {
          send(MainSceneAction.selectList(byId: id))
        }
      }
    }
  }
  
}
