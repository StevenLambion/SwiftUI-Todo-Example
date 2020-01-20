import SwiftUI
import SwiftDux
import Combine

struct TodoListBrowserContainer : View {
  @Environment(\.editMode) private var mode
  @Environment(\.horizontalSizeClass) private var sizeClass
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  
  var body: some View {
    List {
      ForEach(props.todoLists, content: renderRow)
        .onMove(perform: moveTodoList)
        .onDelete(perform: removeTodoLists)
    }
    .navigationBarTitle(Text("Todo Lists"))
    .navigationBarItems(
      leading: EditButton(),
      trailing: AddButton { self.dispatch(TodoListsAction.addNewTodoList()) }
    )
    .onAppear(perform: selectDefaultTodoList)
  }
  
  func renderRow(todoList: TodoList) -> some View {
    TodoListRow(
      todoList: todoList,
      selected: Binding(
        get: { self.props.selectedTodoListId == todoList.id },
        set: { if $0 == true { self.selectTodoList(id: todoList.id) } }
      ),
      destination: self.renderTodoList
    )
  }
  
  func renderTodoList(id: String) -> some View {
    TodoListContainer()
      .connect(with: id)
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
  
  func selectDefaultTodoList() {
    guard props.selectedTodoListId == nil && sizeClass == .regular else { return }
    dispatch(AppAction.selectTodoList(id: props.todoLists.first?.id))
  }

}

extension TodoListBrowserContainer : Connectable {
  
  struct Props {
    var todoLists: OrderedState<TodoList>
    var selectedTodoListId: String?
  }
  
  func map(state: AppState) -> Props? {
    Props(
      todoLists: state.todoLists,
      selectedTodoListId: state.selectedTodoListId
    )
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
        .connect()
        .provideStore(store)
    }
  }
}
#endif
