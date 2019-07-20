import SwiftUI
import SwiftDux

fileprivate let connector = Connector<AppState> { $0 is TodosAction }

struct TodosContainer : View {
  
  var id: String
  
  var body: some View {
    connector.mapToView { state, dispatcher in
      return TodosView(
        todoList: state.todoLists[self.id]!,
        onTodoListNameChange: { dispatcher.send(TodoListsAction.setTodoListName(forId: self.id, name: $0)) },
        onTodoTextChange: { dispatcher.send(TodosAction.setText(forId: $0, text: $1)) },
        onAddTodo: { dispatcher.send(TodosAction.addTodo(text: "New Todo")) },
        onMoveTodos: { dispatcher.send(TodosAction.moveTodos(from: $0, to: $1)) },
        onRemoveTodos: { dispatcher.send(TodosAction.removeTodos(at: $0)) },
        onDeselectTodoList: { dispatcher.send(MainSceneAction.selectList(byId: nil)) }
      )
    }
    .modifier(DispatcherProxy { action in
      if let action = action as? TodosAction {
        return TodoListsAction.routeTodosAction(listId: self.id, action: action)
      }
      return action
    })
  }

}
