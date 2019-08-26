import Foundation
import SwiftUI
import SwiftDux

struct TodoList: IdentifiableState {
  var id: String
  var name: String
  var todos: OrderedState<Todo>
}
