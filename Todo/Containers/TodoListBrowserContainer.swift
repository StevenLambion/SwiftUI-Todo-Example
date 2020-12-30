import SwiftUI
import SwiftDux
import Combine
import AppNavigation

struct TodoListBrowserContainer : ConnectableView, Equatable {
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.sizeClass == rhs.sizeClass
  }

  @Environment(\.horizontalSizeClass) private var sizeClass
  
  func map(state: TodoListsRoot & NavigationStateRoot, binder: ActionBinder) -> Props? {
    Props(
      todoLists: state.todoLists.map { TodoListSummary(id: $0.id, name: $0.name) },
      addNewTodoList: binder.bind(TodoListsAction.addNewTodoList),
      moveTodoLists: binder.bind { TodoListsAction.moveTodoLists(from: $0, to: $1) },
      removeTodoLists: binder.bind { TodoListsAction.removeTodoLists(at: $0) }
    )
  }
  
  func body(props: Props) -> some View {
    Selection(initialValue: sizeClass == .regular ? props.todoLists.first?.id : nil, isDetail: true) { selection in
      List(selection: selection) {
        ForEach(props.todoLists) { todoList in
          TodoListRow(todoList: todoList, selectedId: selection)
        }
        .onMove(perform: props.moveTodoLists)
        .onDelete(perform: props.removeTodoLists)
      }
      .listStyle(PlainListStyle())
      .navigationBarTitle(Text("Todo Lists"))
      .navigationBarItems(
        leading: EditButton(),
        trailing: AddButton(onAdd: props.addNewTodoList)
      )
      .stackItem(.parameter()) {
        TodoListContainer()
      }
    }
  }
}

extension TodoListBrowserContainer{
  struct Props: Equatable {
    var todoLists: [TodoListSummary]
    @ActionBinding var addNewTodoList: ()->()
    @ActionBinding var moveTodoLists: (IndexSet, Int)->()
    @ActionBinding var removeTodoLists: (IndexSet)->()
  }
  
  struct TodoListSummary: Identifiable, Equatable {
    var id: String
    var name: String
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
