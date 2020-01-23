import SwiftUI
import SwiftDux
import Combine

struct TodoContainer : ConnectableView {
  var todoListId: String
  var todoId: String
  
  struct Props: Equatable {
    @Binding var text: String
    @Binding var completed: Bool
  }
  
  func map(state: AppState, binder: StateBinder) -> Props? {
    guard let todo = state.todos[todoId] else { return nil }
    return Props(
      text: binder.bind(todo.text) { TodosAction.setText(id: todo.id, text: $0) },
      completed: binder.bind(todo.completed) {
        TodoListsAction.toggleTodoCompeletion(
          id: self.todoListId,
          todoId: todo.id,
          completed: $0
        )
      }
    )
  }
  
  func body(props: Props) -> some View {
    TodoRow(completed: props.$completed, text: props.$text)
  }
  
}

#if DEBUG
public enum TodoListDetailsRowContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    Store(
      state: AppState(),
      reducer: AppReducer()
    )
  }
  
  public static var previews: some View {
    TodoContainer(todoListId: "123", todoId: "2")
    .provideStore(store)
  }
}
#endif
