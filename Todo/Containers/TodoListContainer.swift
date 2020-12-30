import SwiftUI
import Combine
import SwiftDux
import AppNavigation
import Dispatch

struct TodoListContainer : ConnectableView, Equatable {
  @Environment(\.horizontalSizeClass) private var sizeClass
  @SwiftUI.State private var animate: Bool = false
  
  @WaypointParameter var id: String!
  
  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
  
  func map(state: AppState, binder: ActionBinder) -> Props? {
    guard let todoList = state.todoLists[id] else { return nil }
    return Props(
      todoIds: todoList.todoIds,
      name: binder.bind(todoList.name) {
        TodoListsAction.setName(id: todoList.id, name: $0)
      },
      newTodoText: binder.bind(todoList.newTodoText) {
        TodoListsAction.setNewTodoText(id: todoList.id, text: $0)
      },
      onAddTodo: binder.bind { TodoListsAction.addTodo(id: self.id, text: $0) },
      moveTodoLists: binder.bind { TodoListsAction.moveTodos(id: self.id, from: $0, to: $1) },
      removeTodoLists: binder.bind { TodoListsAction.removeTodos(id: self.id, at: $0) }
    )
  }
  
  func body(props: Props) -> some View {
    VStack {
      TodoListNameField(name: props.$name)
      NewTodoRow(text: props.$newTodoText, onAddTodo: props.onAddTodo).padding()
      renderList(props: props)
    }
  }
  
  func renderList(props: Props) -> some View {
    List {
      ForEach(props.todoIds, id: \.self) { todoId in
        TodoContainer(todoListId: self.id, todoId: todoId)
      }
      .onMove(perform: props.moveTodoLists)
      .onDelete(perform: props.removeTodoLists)
    }
    .listStyle(PlainListStyle())
    .navigationBarTitle(Text(""), displayMode: .inline)
    //.animation(.default)
  }
}

extension TodoListContainer {
  struct Props: Equatable {
    var todoIds: [String]
    @ActionBinding var name: String
    @ActionBinding var newTodoText: String
    @ActionBinding var onAddTodo: (String)->()
    @ActionBinding var moveTodoLists: (IndexSet, Int)->()
    @ActionBinding var removeTodoLists: (IndexSet)->()
  }
}

#if DEBUG
public enum TodoListContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    TodoListContainer()
    .provideStore(store)
  }
}
#endif
