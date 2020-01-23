import SwiftUI
import SwiftDux
import Combine

struct TodoListBrowserContainer : ConnectableView {
  @Environment(\.horizontalSizeClass) private var sizeClass
  @MappedDispatch() private var dispatch
  
  struct Props: Equatable {
    var todoLists: OrderedState<TodoList>
    var selectedTodoListId: String?
  }
  
  func map(state: AppState) -> Props? {
    Props(
      todoLists: state.todoLists,
      selectedTodoListId: state.selectedTodoListId
    )
  }
  
  func body(props: Props) -> some View {
    List {
      ForEach(props.todoLists) { todoList in
        self.renderRow(props: props, todoList: todoList)
      }
      .onMove(perform: moveTodoList)
      .onDelete(perform: removeTodoLists)
    }
    .navigationBarTitle(Text("Todo Lists"))
    .navigationBarItems(
      leading: EditButton(),
      trailing: AddButton { self.dispatch(TodoListsAction.addNewTodoList()) }
    )
      .onAppear { self.selectDefaultTodoList(props: props) }
  }
  
  func renderRow(props: Props, todoList: TodoList) -> some View {
    TodoListRow(
      todoList: todoList,
      selected: Binding(
        get: { props.selectedTodoListId == todoList.id },
        set: { if $0 == true { self.selectTodoList(id: todoList.id) } }
      ),
      destination: self.renderTodoList
    )
  }
  
  func renderTodoList(id: String) -> some View {
    TodoListContainer(id: id)
  }
  
  func addNewTodoList() {
    dispatch(TodoListsAction.addNewTodoList())
  }
  
  func moveTodoList(from indexSet: IndexSet, to index: Int) {
    dispatch(TodoListsAction.moveTodoLists(from: indexSet, to: index))
  }
  
  func removeTodoLists(at indexSet: IndexSet) {
    dispatch(TodoListsAction.removeTodoLists(at: indexSet))
  }
  
  func selectTodoList(id: String) {
    dispatch(AppAction.selectTodoList(id: id))
  }
  
  func selectDefaultTodoList(props: Props) {
    guard props.selectedTodoListId == nil && sizeClass == .regular else { return }
    dispatch(AppAction.selectTodoList(id: props.todoLists.first?.id))
  }

}

#if DEBUG
public enum TodoListBrowserContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    Store(
      state: AppState(),
      reducer: AppReducer()
    )
  }
  
  public static var previews: some View {
    NavigationView {
      TodoListBrowserContainer()
        .provideStore(store)
    }
  }
}
#endif
