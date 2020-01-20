import Foundation
import SwiftDux

final class TodoListsReducer: Reducer {
  
  func reduce(state: OrderedState<TodoList>, action: TodoListsAction) -> OrderedState<TodoList> {
    var state = state
    switch action {
    case .setName(let id, let name):
      state[id] = updateTodoList(todoList: state[id]) { $0.name = name }
    case .setNewTodoText(let id, let text):
      state[id] = updateTodoList(todoList: state[id]) { $0.newTodoText = text }
    case .addTodoId(let id, let todoId):
      state[id] = updateTodoList(todoList: state[id]) { $0.todoIds.insert(todoId, at: 0) }
    case .removeTodoIds(let id, let indexSet):
      state[id] = updateTodoList(todoList: state[id]) { $0.todoIds.remove(at: indexSet) }
    case .addTodoList(let id, let name):
      state.append(TodoList(id: id, name: name, newTodoText: "", todoIds: []))
    case .removeTodoLists(let indexSet):
      state.remove(at: indexSet)
    case .moveTodoLists(let indexSet, let index):
      state.move(from: indexSet, to: index)
    case .moveTodos(let id, let indexSet, let index):
      state[id] = updateTodoList(todoList: state[id]) { $0.todoIds.move(fromOffsets: indexSet, toOffset: index) }
    }
    return state
  }
  
  func updateTodoList(todoList: TodoList?, perform: (inout TodoList) ->()) -> TodoList? {
    guard var todoList = todoList else { return nil }
    perform(&todoList)
    return todoList
  }
}
