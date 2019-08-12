import SwiftUI
import SwiftDux

struct TodoListRowContainer : View {
  
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  
  var name: String {
    props.name.isEmpty ? "Untitled todo list" : props.name
  }
  
  var selected: Binding<Bool> {
    Binding<Bool>(
      get: { self.props.selected },
      set: {
        if $0 {
          self.dispatch(MainSceneAction.selectList(byId: self.props.id))
        }
      }
    )
  }
  
  var body: some View {
    NavigationLink(destination: renderTodoListDetails(), isActive: selected) {
      TodoListRowContentsContainer().connect()
    }
  }
  
  func renderTodoListDetails() -> some View {
    TodoListDetailsContainer()
      .connect(with: props.id)
      .onAction { action in
        if let action = action as? TodosAction {
          return TodoListsAction.routeTodosAction(listId: self.props.id, action: action)
        }
        return nil
      }
  }
}

extension TodoListRowContainer : ParameterizedConnectable {
  
  struct Props {
    var id: String
    var name: String
    var selected: Bool
  }
  
  func updateWhen(action: Action, with parameter: String) -> Bool {
    action is MainSceneAction
  }
  
  func map(state: TodoListsContainer.Props, with parameter: String) -> Props? {
    guard let todoList = state.todoLists[parameter] else { return nil }
    return Props(
      id: parameter,
      name: todoList.name,
      selected: state.selectedListId == parameter
    )
  }
  
}
