import SwiftUI
import SwiftDux
import Combine

struct TodoListBrowserContainer : View {
  @Environment(\.editMode) private var mode
  @Environment(\.horizontalSizeClass) private var sizeClass
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  
  var body: some View {
    renderList()
    .navigationBarTitle(Text("Todo Lists"))
    .navigationBarItems(
      leading: EditButton(),
      trailing: AddButton { self.dispatch(TodoListsAction.addNewTodoList()) }
    )
  }
  
  func renderList() -> some View {
    List {
      ForEach(props.todoLists) { list in
        RowContainer(onSelectRow: self.selectTodoList).connect(with: list.id)
      }
      .onMove(perform: moveTodoList)
      .onDelete(perform: removeTodoLists)
    }.onAppear(perform: selectDefaultTodoList)
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
    var selectedTodoListId: String?
    var todoLists: OrderedState<TodoList>
  }
  
  func map(state: AppState) -> Props? {
    Props(
      selectedTodoListId: state.selectedTodoListId,
      todoLists: state.todoLists
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
