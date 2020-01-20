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

#if DEBUG
public enum TodoListRow_Previews: PreviewProvider {
  
  struct PreviewWrapper: View {
    @State private var todoList = TodoList(
      id: "1",
      name: "TodoList",
      newTodoText: "",
      todoIds: []
    )
    @State private var selected: Bool = false
    
    var body: some View {
      NavigationView {
        TodoListRow(todoList: todoList, selected: $selected) { id in
          Text("Destination: \(id)")
        }
      }
    }
  }
  
  public static var previews: some View {
    PreviewWrapper()
  }
}
#endif
