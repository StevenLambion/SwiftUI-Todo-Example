
import Foundation
import SwiftUI
import SwiftDux

enum TodosAction: Action {
  case setText(forId: String, text: String)
  case setCompleted(forId: String, completed: Bool)
  case addTodo(text: String)
  case removeTodos(at: IndexSet)
  case moveTodos(from: IndexSet, to: Int)
}

final class TodosReducer: Reducer {
  
  func reduce(state: TodoList, action: TodosAction) -> TodoList {
    var state = state
    switch action {
    case .setText(let id, let text):
      if var todo = state.todos[id] {
        todo.text = text
        state.todos[id] = todo
      }
    case .setCompleted(let id, let completed):
      state.todos = reduceCompleted(state: state.todos, forId: id, completed: completed)
    case .addTodo(let text):
      let id = UUID().uuidString
      state.todos.prepend(Todo(id: id, text: text))
    case .removeTodos(let indexSet):
      state.todos.remove(at: indexSet)
    case .moveTodos(let indexSet, let index):
      state.todos.move(from: indexSet, to: index)
    }
    return state
  }
  
  func reduceCompleted(state: OrderedState<Todo>, forId id: String, completed: Bool) -> OrderedState<Todo> {
    var state = state
    guard var todo = state[id], todo.completed != completed else { return state }
    guard let index = state.firstIndex(of: todo) else { return state }
    let lastNonCompletedIndex: Int = state.lastIndex(where: { $0.completed == false }) ?? -1
    let newIndex = lastNonCompletedIndex > -1 ? lastNonCompletedIndex + 1 : (completed ? state.count : 0)
    todo.completed = completed
    state[id] = todo
    state.move(from: IndexSet([index]), to: newIndex)
    return state
  }
  
}
