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
      TodoListNameField(name: props.name)
      renderList()
    }
    .onDisappear(perform: deselectTodoList)
  }
  
  func renderList() -> some View {
    List {
      TodoListDetailsNewTodoContainer(text: props.newTodoText, onAddTodo: addNewTodo)
      ForEach(props.todos) { todo in
        TodoContainer().connect(with: .init(listId: self.props.id, todoId: todo.id))
      }
      .onMove(perform: moveTodoList)
      .onDelete(perform: removeTodoLists)
    }
  }
  
  func addNewTodo(text: String) {
    dispatch(TodoListsAction.addTodo(id: props.id, text: text))
  }
  
  func moveTodoList(from indexSet: IndexSet, to index: Int) {
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
  
  struct Props {
    var id: String
    var name: Binding<String>
    var newTodoText: Binding<String>
    var todos: [Todo]
  }
  
  func updateWhen(action: Action, with parameter: String) -> Bool {
    action is TodoListsAction
  }
  
  func map(state: AppState, with parameter: String, binder: StateBinder) -> Props? {
    guard let todoList = state.todoLists[parameter] else { return nil }
    return Props(
      id: todoList.id,
      name: binder.bind(todoList.name) {
        TodoListsAction.setName(id: todoList.id, name: $0)
      },
      newTodoText: binder.bind(todoList.newTodoText) {
        TodoListsAction.setNewTodoText(id: todoList.id, text: $0)
      },
      todos: todoList.todoIds.map { state.todos[$0]! }
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
