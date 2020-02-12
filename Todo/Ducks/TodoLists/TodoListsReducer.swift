import Foundation
import SwiftDux

final class TodoListsReducer<State>: Reducer where State: TodoListsRoot {
  
  func reduce(state: State, action: TodoListsAction) -> State {
    var state = state
    switch action {
    case .selectTodoList(let id):
      state.selectedTodoListId = id
    case .setName(let id, let name):
      state.todoLists[id] = updateTodoList(todoList: state.todoLists[id]) { $0.name = name }
    case .setNewTodoText(let id, let text):
      state.todoLists[id] = updateTodoList(todoList: state.todoLists[id]) { $0.newTodoText = text }
    case .addTodoId(let id, let todoId):
      state.todoLists[id] = updateTodoList(todoList: state.todoLists[id]) { $0.todoIds.insert(todoId, at: 0) }
    case .removeTodoIds(let id, let indexSet):
      state.todoLists[id] = updateTodoList(todoList: state.todoLists[id]) { $0.todoIds.remove(at: indexSet) }
    case .addTodoList(let id, let name):
      state.todoLists.append(TodoList(id: id, name: name, newTodoText: "", todoIds: []))
    case .removeTodoLists(let indexSet):
      state.todoLists.remove(at: indexSet)
    case .moveTodoLists(let indexSet, let index):
      state.todoLists.move(from: indexSet, to: index)
    case .moveTodos(let id, let indexSet, let index):
      state.todoLists[id] = updateTodoList(todoList: state.todoLists[id]) { $0.todoIds.move(fromOffsets: indexSet, toOffset: index) }
    }
    return state
  }
  
  func updateTodoList(todoList: TodoList?, perform: (inout TodoList) ->()) -> TodoList? {
    guard var todoList = todoList else { return nil }
    perform(&todoList)
    return todoList
  }
}
