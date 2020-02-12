import Foundation
import SwiftDux

final class TodosReducer<State>: Reducer where State: TodosRoot  {
  
  func reduce(state: State, action: TodosAction) -> State {
    var state = state
    switch action {
    case .addTodo(let id, let text):
      state.todos[id] = Todo(id: id, text: text)
    case .setText(let id, let text):
      state.todos[id] = updateTodo(todo: state.todos[id]) { $0.text = text }
    case .setCompleted(let id, let completed):
      state.todos[id] = updateTodo(todo: state.todos[id]) { $0.completed = completed }
    case .removeTodos(let ids):
      ids.forEach { state.todos.removeValue(forKey: $0) }
    }
    return state
  }
  
  func updateTodo(todo: Todo?, perform: (inout Todo) ->()) -> Todo? {
    guard var todo = todo else { return nil }
    perform(&todo)
    return todo
  }
}
