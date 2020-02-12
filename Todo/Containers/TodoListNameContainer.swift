import SwiftUI
import Combine
import SwiftDux

struct TodoListNameContainer : ConnectableView {
  var id: String
  
  func map(state: AppState, binder: ActionBinder) -> ActionBinding<String>? {
    guard let todoList = state.todoLists[id] else { return nil }
    return binder.bind(todoList.name) {
      TodoListsAction.setName(id: todoList.id, name: $0)
    }
  }
  
  func body(props: ActionBinding<String>) -> some View {
    TodoListNameField(name: props.projectedValue)
  }
}

#if DEBUG
public enum TodoListNameContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    TodoListNameContainer(id: "123")
    .provideStore(store)
  }
}
#endif
