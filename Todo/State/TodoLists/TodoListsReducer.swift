import Foundation
import SwiftDux

enum TodoListsAction: Action {
  case setTodoListName(forId: String, name: String)
  case addTodoList(name: String)
  case removeTodoLists(at: IndexSet)
  case moveTodoLists(from: IndexSet, to: Int)
  case routeTodosAction(listId: String, action: TodosAction)
}

class TodoListsReducer: Reducer {
  
  let todosReducer = TodosReducer()
  
  func reduce(state: OrderedState<TodoList>, action: TodoListsAction) -> OrderedState<TodoList> {
    var state = state
    switch action {
    case .setTodoListName(let id, let name):
      if var todoList = state[id] {
        todoList.name = name
        state[id] = todoList
      }
    case .addTodoList(let name):
      let id = UUID().uuidString
      state.append(TodoList(id: id, name: name, todos: OrderedState()))
    case .removeTodoLists(let indexSet):
      state.remove(at: indexSet)
    case .moveTodoLists(let indexSet, let index):
      state.move(from: indexSet, to: index)
    case .routeTodosAction(let listId, let action):
      if let todoList = state[listId] {
        state[listId] = todosReducer.reduceAny(state: todoList, action: action)
      }
    }
    return state
  }
  
}
