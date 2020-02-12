import SwiftUI
import Combine
import SwiftDux

struct NewTodoContainer : ConnectableView {
  var id: String
  
  @MappedDispatch() private var dispatch
  
  struct Props: Equatable {
    @ActionBinding var newTodoText: String
  }
  
  func map(state: AppState, binder: ActionBinder) -> Props? {
    guard let todoList = state.todoLists[id] else { return nil }
    return Props(
      newTodoText: binder.bind(todoList.newTodoText) {
        TodoListsAction.setNewTodoText(id: todoList.id, text: $0)
      }
    )
  }
  
  func body(props: Props) -> some View {
    NewTodoRow(text: props.$newTodoText) {
      self.dispatch(TodoListsAction.addTodo(id: self.id, text: $0))
    }.padding()
  }

}

#if DEBUG
public enum NewTodoContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    NewTodoContainer(id: "123")
    .provideStore(store)
  }
}
#endif
