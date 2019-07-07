import SwiftUI
import SwiftDux
import Combine

fileprivate let connector = Connector<AppState> { $0 is TodoListsAction || $0 is MainSceneAction }

struct TodoListsContainer : View {
  @Environment(\.editMode) var mode
  
  /// SwiftUI in beta 3 has a bug in which environment objects can't be accessed through a NavigationLink. Once fixed, these can be removed.
  @EnvironmentObject var storeContext: StoreContext<AppState>
  @EnvironmentObject var dispatcherContext: DispatcherContext
  
  var body: some View {
    connector.mapToView { state, dispatcher in
      TodoListsView(
        todoLists: state.todoLists,
        renderDetailContainer: self.renderDetailContainer,
        onAddTodoList: { dispatcher.send(TodoListsAction.addTodoList(name: "")) },
        onMoveTodoLists: { dispatcher.send(TodoListsAction.moveTodoLists(from: $0, to: $1)) },
        onRemoveTodoLists: { dispatcher.send(TodoListsAction.removeTodoLists(at: $0)) }
      )
    }
  }
  
  func renderDetailContainer(list: TodoList) -> AnyView {
    AnyView(
      TodosContainer(id: list.id)
        .environmentObject(storeContext)
        .environmentObject(dispatcherContext)
    )
  }

}
