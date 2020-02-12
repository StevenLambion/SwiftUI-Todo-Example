import SwiftUI
import Combine
import SwiftDux

struct TodoListContainer : ConnectableView {
  var id: String
  
  @Environment(\.horizontalSizeClass) private var sizeClass
  @MappedDispatch() private var dispatch
  
  func map(state: AppState) -> [String]? {
    state.todoLists[id]?.todoIds
  }
  
  func body(props: Props) -> some View {
    VStack {
      TodoListNameContainer(id: id)
      NewTodoContainer(id: id)
      renderList(props: props)
    }
    .onDisappear(perform: deselectTodoList)
  }
  
  func renderList(props: Props) -> some View {
    List {
      ForEach(props, id: \.self) { todoId in
        TodoContainer(todoListId: self.id, todoId: todoId)
      }
      .onMove(perform: moveTodoLists)
      .onDelete(perform: removeTodoLists)
    }
  }
  
  func addNewTodo(text: String) {
    dispatch(TodoListsAction.addTodo(id: id, text: text))
  }
  
  func moveTodoLists(from indexSet: IndexSet, to index: Int) {
    dispatch(TodoListsAction.moveTodos(id: id, from: indexSet, to: index))
  }
  
  func removeTodoLists(at indexSet: IndexSet) {
    dispatch(TodoListsAction.removeTodos(id: id, at: indexSet))
  }
  
  func deselectTodoList() {
    if self.sizeClass == .compact {
      self.dispatch(TodoListsAction.selectTodoList(id: nil))
    }
  }
}

#if DEBUG
public enum TodoListContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    TodoListContainer(id: "123")
    .provideStore(store)
  }
}
#endif
