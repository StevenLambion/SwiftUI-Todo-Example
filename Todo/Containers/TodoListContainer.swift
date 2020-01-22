import SwiftUI
import Combine
import SwiftDux

struct TodoListContainer : View {
  @Environment(\.horizontalSizeClass) var sizeClass
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  @SwiftUI.State private var editMode: EditMode = .inactive
  
  var body: some View {
    VStack {
      TodoListNameContainer().connect(with: props.id)
      renderList()
    }
    .onDisappear(perform: deselectTodoList)
  }
  
  func renderList() -> some View {
    List {
      NewTodoContainer().connect(with: self.props.id)
      ForEach(props.todoIds, id: \.self) { id in
        TodoContainer().connect(with: (listId: self.props.id, todoId: id))
      }
      .onMove(perform: moveTodoLists)
      .onDelete(perform: removeTodoLists)
    }
  }
  
  func addNewTodo(text: String) {
    dispatch(TodoListsAction.addTodo(id: props.id, text: text))
  }
  
  func moveTodoLists(from indexSet: IndexSet, to index: Int) {
    dispatch(TodoListsAction.moveTodos(id: props.id, from: indexSet, to: index))
  }
  
  func removeTodoLists(at indexSet: IndexSet) {
    dispatch(TodoListsAction.removeTodos(id: props.id, at: indexSet))
  }
  
  func deselectTodoList() {
    if self.sizeClass == .compact {
      self.dispatch(AppAction.selectTodoList(id: nil))
    }
  }
}
  
extension TodoListContainer : ParameterizedConnectable {
  
  struct Props: Equatable {
    var id: String
    var todoIds: [String]
  }
  
  func map(state: AppState, with parameter: String) -> Props? {
    guard let todoList = state.todoLists[parameter] else { return nil }
    return Props(
      id: todoList.id,
      todoIds: todoList.todoIds
    )
  }
}

#if DEBUG
public enum TodoListContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    Store(
      state: AppState(),
      reducer: AppReducer()
    )
  }
  
  public static var previews: some View {
    TodoListContainer()
      .connect(with: "123")
    .provideStore(store)
  }
}
#endif
