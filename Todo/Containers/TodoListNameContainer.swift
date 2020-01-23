import SwiftUI
import Combine
import SwiftDux

struct TodoListNameContainer : ConnectableView {
  var id: String
  
  func map(state: AppState, binder: StateBinder) -> Binding<String>? {
    guard let todoList = state.todoLists[id] else { return nil }
    return binder.bind(todoList.name) {
      TodoListsAction.setName(id: todoList.id, name: $0)
    }
  }
  
  func body(props: Binding<String>) -> some View {
    TodoListNameField(name: props)
  }
}

#if DEBUG
public enum TodoListNameContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    Store(
      state: AppState(),
      reducer: AppReducer()
    )
  }
  
  public static var previews: some View {
    TodoListNameContainer(id: "123")
    .provideStore(store)
  }
}
#endif
