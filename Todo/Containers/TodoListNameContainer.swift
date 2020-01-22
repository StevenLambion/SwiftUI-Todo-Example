import SwiftUI
import Combine
import SwiftDux

struct TodoListNameContainer : View {
  @MappedState private var props: Props
  
  var body: some View {
    TodoListNameField(name: props.$name)
  }

}
  
extension TodoListNameContainer : ParameterizedConnectable {
  
  struct Props: Equatable {
    @Binding var name: String
  }
  
  func map(state: AppState, with parameter: String, binder: StateBinder) -> Props? {
    guard let todoList = state.todoLists[parameter] else { return nil }
    return Props(
      name: binder.bind(todoList.name) {
        TodoListsAction.setName(id: todoList.id, name: $0)
      }
    )
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
    TodoListNameContainer()
      .connect(with: "123")
    .provideStore(store)
  }
}
#endif
