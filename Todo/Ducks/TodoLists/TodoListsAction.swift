import Foundation
import Combine
import SwiftDux
import AppNavigation

enum TodoListsAction: Action {
  case selectTodoList(id: String?)
  case addTodoList(id: String, name: String)
  case removeTodoLists(at: IndexSet)
  case moveTodoLists(from: IndexSet, to: Int)
  case setName(id: String, name: String)
  case setNewTodoText(id: String, text: String)
  case addTodoId(id: String, todoId: String)
  case moveTodos(id: String, from: IndexSet, to: Int)
  case removeTodoIds(id: String, at: IndexSet)
}

extension TodoListsAction {
  
  static func addNewTodoList() -> ActionPlan<TodoListsRoot> {
    ActionPlan { store in
      Just(UUID().uuidString).map { id -> Action in
        TodoListsAction.addTodoList(id: id, name: "") +
        TodoListsAction.selectTodoList(id: id)
      }
    }
  }
  
  static func addTodo(id: String, text: String) -> ActionPlan<TodoListsRoot> {
    ActionPlan { store in
      Just(UUID().uuidString).map { todoId -> Action in
        TodosAction.addTodo(id: todoId, text: text) +
        TodoListsAction.addTodoId(id: id, todoId: todoId)
      }
    }
  }
  
  static func removeTodos(id: String, at indexSet: IndexSet) -> ActionPlan<TodoListsRoot> {
    ActionPlan { store in
      Just(store.state.todoLists[id]?.todoIds ?? []).map { todoIds -> Action in
        TodosAction.removeTodos(ids: indexSet.map { todoIds[$0] }) +
        TodoListsAction.removeTodoIds(id: id, at: indexSet)
      }
    }
  }
   
  static func toggleTodoCompeletion(id: String, todoId: String, completed: Bool) -> ActionPlan<TodoListsRoot> {
    ActionPlan { store in
      Just(store.state).compactMap { state -> Action? in
        guard
          let todoList = state.todoLists[id],
          let todo = state.todos[todoId],
          let index = todoList.todoIds.firstIndex(of: todo.id)
        else { return nil }
        let lastNonCompletedIndex: Int = todoList.todoIds.lastIndex(where: { state.todos[$0]?.completed == false }) ?? -1
        let newIndex = lastNonCompletedIndex > -1 ? lastNonCompletedIndex + 1 : (completed ? todoList.todoIds.count : 0)
        
        return
          TodosAction.setCompleted(id: todoId, completed: completed) +
          TodoListsAction.moveTodos(id: id, from: IndexSet([index]), to: newIndex)
      }
    }
  }
}
