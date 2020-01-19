import Foundation
import SwiftDux

enum TodosAction: Action {
  case setText(id: String, text: String)
  case setCompleted(id: String, completed: Bool)
  case addTodo(id: String, text: String)
  case removeTodos(ids: [String])
}
