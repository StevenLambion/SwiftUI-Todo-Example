import Foundation
import SwiftDux

enum MainSceneDisplayMode {
  case compact
  case regular
}

/// The state of the main UIScene of the application.
struct MainScene: StateType {
  var displayMode: MainSceneDisplayMode = .compact
  var selectedListId: String? = nil
  
  private enum CodingKeys: String, CodingKey {
    case selectedListId
  }
  
  init(displayMode: MainSceneDisplayMode = .compact, selectedListId: String? = nil) {
    self.displayMode = displayMode
    self.selectedListId = selectedListId
  }
}
