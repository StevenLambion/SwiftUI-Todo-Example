
import Foundation
import SwiftDux

final class TodosReducer: Reducer {
  
  func reduce(state: [String:Todo], action: TodosAction) -> [String:Todo] {
    var state = state
    switch action {
    case .addTodo(let id, let text):
      state[id] = Todo(id: id, text: text)
    case .setText(let id, let text):
      state[id] = updateTodo(todo: state[id]) { $0.text = text }
    case .setCompleted(let id, let completed):
      state[id] = updateTodo(todo: state[id]) { $0.completed = completed }
    case .removeTodos(let ids):
      ids.forEach { state.removeValue(forKey: $0) }
    }
    return state
  }
  
  func updateTodo(todo: Todo?, perform: (inout Todo) ->()) -> Todo? {
    guard var todo = todo else { return nil }
    perform(&todo)
    return todo
  }
}
