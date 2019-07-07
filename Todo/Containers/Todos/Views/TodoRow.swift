import SwiftUI

struct TodoRow : View {
  var todo: Todo
  var onTodoTextChange: (String, String) -> ()
  
  private var text: Binding<String> {
    Binding<String>(
      getValue: { self.todo.text },
      setValue: { self.onTodoTextChange(self.todo.id, $0) }
    )
  }
  
  var body: some View {
    TextField("", text: text)
  }
}
