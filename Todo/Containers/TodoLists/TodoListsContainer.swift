import SwiftUI
import SwiftDux
import Combine

struct TodoListsContainer : View {
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
        TodoListRowContainer().connect(with: list.id)
      }
      .onMove { self.dispatch(TodoListsAction.moveTodoLists(from: $0, to: $1)) }
      .onDelete { self.dispatch(TodoListsAction.removeTodoLists(at: $0)) }
    }.onAppear {
      guard self.props.selectedListId == nil && self.sizeClass == .regular else { return }
      self.dispatch(MainSceneAction.selectList(byId: self.props.todoLists.first?.id))
    }
  }

}

extension TodoListsContainer : Connectable {
  
  struct Props {
    var selectedListId: String?
    var todoLists: OrderedState<TodoList>
  }
  
  func map(state: AppState) -> Props? {
    Props(
      selectedListId: state.mainScene.selectedListId,
      todoLists: state.todoLists
    )
  }
  
}
