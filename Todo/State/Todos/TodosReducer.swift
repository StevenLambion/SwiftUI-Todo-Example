
import Foundation
import SwiftUI
import SwiftDux

enum TodosAction: Action {
  case setText(forId: String, text: String)
  case addTodo(text: String)
  case removeTodos(at: IndexSet)
  case moveTodos(from: IndexSet, to: Int)
}

class TodosReducer: Reducer {
  
  func reduce(state: TodoList, action: TodosAction) -> TodoList {
    var state = state
    switch action {
    case .setText(let id, let text):
      if var todo = state.todos[id] {
        todo.text = text
        state.todos[id] = todo
      }
    case .addTodo(let text):
      let id = UUID().uuidString
      state.todos.append(Todo(id: id, text: text))
    case .removeTodos(let indexSet):
      state.todos.remove(at: indexSet)
    case .moveTodos(let indexSet, let index):
      state.todos.move(from: indexSet, to: index)
    }
    return state
  }
  
}
