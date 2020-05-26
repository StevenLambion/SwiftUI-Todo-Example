import SwiftUI
import SwiftDux
import Combine
import AppNavigation

struct TodoListBrowserContainer : ConnectableView {
  @Environment(\.waypoint) private var waypoint
  @Environment(\.horizontalSizeClass) private var sizeClass
  @MappedDispatch() private var dispatch
  
  func map(state: TodoListsRoot & NavigationStateRoot, binder: ActionBinder) -> Props? {
    let scene = waypoint.resolveSceneState(in: state)
    return Props(
      todoLists: state.todoLists,
      selectedTodoListId: scene?.detailRoute.legsByPath["/todoList/"]?.component,
      addNewTodoList: binder.bind(TodoListsAction.addNewTodoList),
      moveTodoLists: binder.bind { TodoListsAction.moveTodoLists(from: $0, to: $1) },
      removeTodoLists: binder.bind { TodoListsAction.removeTodoLists(at: $0) }
    )
  }
  
  func body(props: Props) -> some View {
    if sizeClass != .compact && props.selectedTodoListId == nil {
      if let id = props.todoLists.first?.id {
        dispatch(waypoint.navigate(to: "todoList/\(id)", isDetail: true))
      }
    }
    return SplitNavigationView {
      list(props: props)
    }
    .detailItem {
      Text("Select or add a new a Todo List.")
    }
    .detailItem("todoList") { (id: String) in
      TodoListContainer(id: id)
    }
  }
  
  func list(props: Props) -> some View {
    List {
      ForEach(props.todoLists) { todoList in
        TodoListRow(todoList: todoList, selected: props.selectedTodoListId == todoList.id)
      }
      .onMove(perform: props.moveTodoLists)
      .onDelete(perform: props.removeTodoLists)
    }
    .navigationBarTitle(Text("Todo Lists"))
    .navigationBarItems(
      leading: EditButton(),
      trailing: AddButton(onAdd: props.addNewTodoList)
    )
  }
}

extension TodoListBrowserContainer{
  struct Props: Equatable {
    var todoLists: OrderedState<TodoList>
    var selectedTodoListId: String?
    @ActionBinding var addNewTodoList: ()->()
    @ActionBinding var moveTodoLists: (IndexSet, Int)->()
    @ActionBinding var removeTodoLists: (IndexSet)->()
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
