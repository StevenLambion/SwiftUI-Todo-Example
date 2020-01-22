import SwiftUI
import Combine
import SwiftDux

struct NewTodoContainer : View {
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  
  var body: some View {
    NewTodoRow(text: self.props.$newTodoText, onAddTodo: self.addNewTodo)
  }
  
  func addNewTodo(text: String) {
    dispatch(TodoListsAction.addTodo(id: props.id, text: text))
  }
}
  
extension NewTodoContainer : ParameterizedConnectable {
  
  struct Props: Equatable {
    var id: String
    @Binding var newTodoText: String
  }
  
  func map(state: AppState, with parameter: String, binder: StateBinder) -> Props? {
    guard let todoList = state.todoLists[parameter] else { return nil }
    return Props(
      id: parameter,
      newTodoText: binder.bind(todoList.newTodoText) {
        TodoListsAction.setNewTodoText(id: todoList.id, text: $0)
      }
    )
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
    NewTodoContainer()
      .connect(with: "123")
    .provideStore(store)
  }
}
#endif
