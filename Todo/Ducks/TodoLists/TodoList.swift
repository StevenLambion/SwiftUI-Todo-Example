import Foundation
import SwiftDux

struct TodoList: IdentifiableState {
  var id: String
  var name: String
  var newTodoText: String
  var todoIds: [String]
}
