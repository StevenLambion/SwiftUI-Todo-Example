import SwiftUI
import SwiftDux
import Combine

fileprivate let connector = Connector<AppState> { $0 is TodoListsAction || $0 is MainSceneAction }

struct TodoListsContainer : View {
  @Environment(\.editMode) var mode
  
  var body: some View {
    connector.mapToView { state, dispatcher -> TodoListsView in
      TodoListsView(
        todoLists: state.todoLists,
        selectedTodoList: Binding<TodoList?>(
          getValue: {
            guard let id = state.mainScene.selectedListId else { return nil }
            return state.todoLists[id]
          },
          setValue: { dispatcher.send(MainSceneAction.selectList(byId: $0?.id)) }
        ),
        onAddTodoList: { dispatcher.send(TodoListsAction.addNewTodoList()) },
        onMoveTodoLists: { dispatcher.send(TodoListsAction.moveTodoLists(from: $0, to: $1)) },
        onRemoveTodoLists: { dispatcher.send(TodoListsAction.removeTodoLists(at: $0)) }
      )
    }
  }

}
