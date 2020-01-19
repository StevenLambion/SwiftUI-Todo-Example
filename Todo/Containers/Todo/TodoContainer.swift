import SwiftUI
import SwiftDux
import Combine

struct TodoContainer : View {
  
  @MappedState private var props: Props
  
  var body: some View {
    TodoListDetailsRow(completed: props.completed, text: props.text)
  }
  
}

extension TodoContainer : ParameterizedConnectable {
  
  struct Props {
    var text: Binding<String>
    var completed: Binding<Bool>
  }
  
  struct Parameter {
    var listId: String
    var todoId: String
  }
  
  func map(state: AppState, with parameter: Parameter, binder: StateBinder) -> Props? {
    guard
      let todo = state.todos[parameter.todoId]
    else { return nil }
      return Props(
        text: binder.bind(todo.text) { TodosAction.setText(id: todo.id, text: $0) },
        completed: binder.bind(todo.completed) {
          TodoListsAction.toggleTodoCompeletion(
            todoListId: parameter.listId,
            todoId: todo.id,
            completed: $0
          )
        }
    )
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
    TodoContainer()
      .connect(with: .init(listId: "123", todoId: "2"))
    .provideStore(store)
  }
  
}
#endif
