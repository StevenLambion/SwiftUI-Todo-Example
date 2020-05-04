import SwiftUI
import SwiftDux
import Combine

struct TodoListBrowserContainer : ConnectableView {
  @Environment(\.horizontalSizeClass) private var sizeClass
  
  func map(state: AppState, binder: ActionBinder) -> Props? {
    Props(
      todoLists: state.todoLists,
      selectedTodoListId: binder.bind(state.selectedTodoListId) {
        TodoListsAction.selectTodoList(id: $0)
      },
      addNewTodoList: binder.bind(TodoListsAction.addNewTodoList),
      moveTodoLists: binder.bind { TodoListsAction.moveTodoLists(from: $0, to: $1) },
      removeTodoLists: binder.bind { TodoListsAction.removeTodoLists(at: $0) },
      selectDefaultTodoList: binder.bind {
        guard state.selectedTodoListId == nil && self.sizeClass == .regular else { return nil }
        return TodoListsAction.selectTodoList(id: state.todoLists.first?.id)
      }
    )
  }
  
  func body(props: Props) -> some View {
    List {
      ForEach(props.todoLists) { todoList in
        self.row(todoList: todoList, selectedTodoListId: props.$selectedTodoListId)
      }
      .onMove(perform: props.moveTodoLists)
      .onDelete(perform: props.removeTodoLists)
    }
    .navigationBarTitle(Text("Todo Lists"))
    .navigationBarItems(
      leading: EditButton(),
      trailing: AddButton(onAdd: props.addNewTodoList)
    )
    .onAppear { props.selectDefaultTodoList() }
  }
  
  func row(todoList: TodoList, selectedTodoListId: Binding<String?>) -> some View {
    TodoListRow(
      todoList: todoList,
      selectedId: selectedTodoListId,
      destination: TodoListContainer(id: todoList.id)
    )
  }
}

extension TodoListBrowserContainer{
  struct Props: Equatable {
    var todoLists: OrderedState<TodoList>
    @ActionBinding var selectedTodoListId: String?
    @ActionBinding var addNewTodoList: ()->()
    @ActionBinding var moveTodoLists: (IndexSet, Int)->()
    @ActionBinding var removeTodoLists: (IndexSet)->()
    @ActionBinding var selectDefaultTodoList: ()->()
  }
}

#if DEBUG
public enum TodoListBrowserContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    NavigationView {
      TodoListBrowserContainer()
        .provideStore(store)
    }
  }
}
#endif
