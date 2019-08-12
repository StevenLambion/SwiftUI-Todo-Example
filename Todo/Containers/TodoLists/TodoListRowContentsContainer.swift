import SwiftUI
import SwiftDux

struct TodoListRowContentsContainer : View {
  
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  
  var name: String {
    props.name.isEmpty ? "Untitled todo list" : props.name
  }
  
  var body: some View {
    TodoListRow(name: name)
  }
  
}

extension TodoListRowContentsContainer : Connectable {
  
  typealias Props = TodoListRowContainer.Props
  
  func updateWhen(action: Action) -> Bool {
    action is TodoListsAction
  }
  
  func map(state: Props) -> Props? {
    state
  }
  
}
