import Foundation
import SwiftUI
import SwiftDux

struct TodoList: IdentifiableState, Identifiable {
  var id: String
  var name: String
  var todos: OrderedState<Todo>
}
