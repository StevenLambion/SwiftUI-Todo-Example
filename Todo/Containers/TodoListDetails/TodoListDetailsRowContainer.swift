import SwiftUI
import SwiftDux
import Combine

struct TodoListDetailsRowContainer : View {
  
  @MappedState private var props: Props
  
  var body: some View {
    TodoListDetailsRow(completed: props.completed, text: props.text)
  }
  
}

extension TodoListDetailsRowContainer : ParameterizedConnectable {
  
  struct Props {
    var text: Binding<String>
    var completed: Binding<Bool>
  }
  
  func map(state: TodoList, with parameter: String, binder: StateBinder) -> Props? {
    guard let todo = state.todos[parameter] else { return nil }
    return Props(
      text: binder.bind(todo.text) { TodosAction.setText(forId: todo.id, text: $0) },
      completed: binder.bind(todo.completed) { TodosAction.setCompleted(forId: todo.id, completed: $0) }
    )
  }
  
}
