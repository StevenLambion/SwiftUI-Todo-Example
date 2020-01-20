import SwiftUI

struct TodoListRow<Destination> : View where Destination: View {
  var todoList: TodoList
  var selected: Binding<Bool>
  var destination: (String) -> Destination
  
  var body: some View {
    NavigationLink(destination: destination(todoList.id), isActive: selected) {
      Text(verbatim: todoList.name.isEmpty ? "Untitled todo list" : todoList.name)
    }
  }
}
