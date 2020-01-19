import SwiftUI
import SwiftDux

struct TodoListDetailsNewTodoContainer : View {
  
  @Binding var text: String
  
  var onAddTodo: (String) -> ()
  
  var body: some View {
    TextField("New todo", text: $text, onCommit: onEnter)
  }
  
  func onEnter() {
    onAddTodo(text)
    text = ""
  }

}
