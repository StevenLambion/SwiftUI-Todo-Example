import SwiftUI
import Combine
import SwiftDux

struct TodoListDetailsNameContainer : View {
  
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  
  private var name: Binding<String> {
    Binding<String>(
      get: { self.props.name },
      set: { self.dispatch(TodoListsAction.setTodoListName(forId: self.props.id, name: $0)) }
    )
  }
  
  var body: some View {
    TodoListDetailsNameField(name: name)
  }

}

extension TodoListDetailsNameContainer : Connectable {
  
  struct Props {
    var id: String
    var name: String
  }
  
  func updateWhen(action: Action) -> Bool {
    action is TodoListsAction
  }

  func map(state: TodoList) -> Props? {
    Props(
      id: state.id,
      name: state.name
    )
  }

}
