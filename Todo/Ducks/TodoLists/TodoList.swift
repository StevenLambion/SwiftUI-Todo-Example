import Foundation
import SwiftDux

struct TodoList: StateType, Identifiable {
  var id: String
  var name: String
  var newTodoText: String
  var todoIds: [String]
}
