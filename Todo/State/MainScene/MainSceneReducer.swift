import Foundation
import SwiftDux

class MainSceneReducer: Reducer {
  
  func reduce(state: MainScene, action: MainSceneAction) -> MainScene {
    var state = state
    switch action {
    case .setDisplayMode(let mode):
      state.displayMode = mode
    case .selectList(let id):
      state.selectedListId = id
    }
    return state
  }
  
}
