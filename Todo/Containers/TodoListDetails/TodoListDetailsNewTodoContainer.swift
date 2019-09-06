import SwiftUI
import SwiftDux

struct TodoListDetailsNewTodoContainer : View {
  
  @State private var todoText: String = ""
  @MappedDispatch() private var dispatch
  
  var body: some View {
    TextField("New todo", text: $todoText) {
      self.dispatch(TodosAction.addTodo(text: self.todoText))
      self.todoText = ""
    }
  }

}
