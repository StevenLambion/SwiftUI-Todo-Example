import SwiftUI
import Combine
import SwiftDux

struct NewTodoContainer : ConnectableView {
  @MappedDispatch() private var dispatch
  
  var id: String
  
  func map(state: AppState, binder: StateBinder) -> Binding<String>? {
    guard let todoList = state.todoLists[id] else { return nil }
    return binder.bind(todoList.newTodoText) {
      TodoListsAction.setNewTodoText(id: todoList.id, text: $0)
    }
  }
  
  func body(props: Props) -> some View {
    NewTodoRow(text: props) {
      self.dispatch(TodoListsAction.addTodo(id: self.id, text: $0))
    }.padding()
  }

}

#if DEBUG
public enum NewTodoContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    Store(
      state: AppState(),
      reducer: AppReducer()
    )
  }
  
  public static var previews: some View {
    NewTodoContainer(id: "123")
    .provideStore(store)
  }
}
#endif
