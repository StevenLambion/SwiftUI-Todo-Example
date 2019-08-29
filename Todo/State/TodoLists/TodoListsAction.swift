import Foundation
import SwiftDux

enum TodoListsAction: Action {
  case setTodoListName(forId: String, name: String)
  case createTodoList(name: String, id: String)
  case removeTodoLists(at: IndexSet)
  case moveTodoLists(from: IndexSet, to: Int)
  case routeTodosAction(listId: String, action: TodosAction)
}

extension TodoListsAction {
  
  static func addNewTodoList() -> ActionPlan<AppState> {
    ActionPlan { store in
      let id = UUID().uuidString
      store.send(TodoListsAction.createTodoList(name: "", id: id))
      store.send(MainSceneAction.selectList(byId: id))
    }
  }
  
}
