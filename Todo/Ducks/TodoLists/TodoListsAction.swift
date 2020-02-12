import Foundation
import SwiftDux

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
      let id = UUID().uuidString
      store.send(TodoListsAction.addTodoList(id: id, name: ""))
      store.send(TodoListsAction.selectTodoList(id: id))
    }
  }
  
  static func addTodo(id: String, text: String) -> ActionPlan<TodoListsRoot> {
    ActionPlan { store in
      let todoId = UUID().uuidString
      store.send(TodosAction.addTodo(id: todoId, text: text))
      store.send(TodoListsAction.addTodoId(id: id, todoId: todoId))
    }
  }
  
  static func removeTodos(id: String, at indexSet: IndexSet) -> ActionPlan<TodoListsRoot> {
    ActionPlan { store in
      let todoIds: [String] = store.state.todoLists[id]?.todoIds ?? []
      store.send(TodosAction.removeTodos(ids: indexSet.map { todoIds[$0] }))
      store.send(TodoListsAction.removeTodoIds(id: id, at: indexSet))
    }
  }
   
  static func toggleTodoCompeletion(id: String, todoId: String, completed: Bool) -> ActionPlan<TodoListsRoot> {
    ActionPlan { store in
      let todoLists = store.state.todoLists
      let todos = store.state.todos
      guard
        let todoList = todoLists[id],
        let todo = todos[todoId],
        let index = todoList.todoIds.firstIndex(of: todo.id)
      else { return }
      let lastNonCompletedIndex: Int = todoList.todoIds.lastIndex(where: { todos[$0]?.completed == false }) ?? -1
      let newIndex = lastNonCompletedIndex > -1 ? lastNonCompletedIndex + 1 : (completed ? todoList.todoIds.count : 0)
      
      store.send(TodosAction.setCompleted(id: todoId, completed: completed))
      store.send(TodoListsAction.moveTodos(id: id, from: IndexSet([index]), to: newIndex))
    }
  }
}
