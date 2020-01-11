import SwiftUI
import Combine
import SwiftDux

struct TodoListDetailsNameContainer : View {
  
  @MappedState private var props: Props
  
  var body: some View {
    TodoListDetailsNameField(name: props.name)
  }

}

extension TodoListDetailsNameContainer : Connectable {
  
  struct Props {
    var name: Binding<String>
  }
  
  func map(state: TodoList, binder: StateBinder) -> Props? {
    Props(
      name: binder.bind(state.name) {
        TodoListsAction.setTodoListName(forId: state.id, name: $0)
      }
    )
  }

}
