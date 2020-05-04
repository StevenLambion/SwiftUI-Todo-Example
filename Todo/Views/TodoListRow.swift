import SwiftUI

struct TodoListRow<Destination> : View where Destination: View {
  var todoList: TodoList
  @Binding var selectedId: String?
  var destination: Destination
  
  var body: some View {
    NavigationLink(destination: destination, tag: todoList.id, selection: $selectedId) {
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
    @State private var selected: String? = "1"
    
    var body: some View {
      NavigationView {
        TodoListRow(todoList: todoList, selectedId: $selected, destination: Text("Destination"))
      }
    }
  }
  
  public static var previews: some View {
    PreviewWrapper()
  }
}
#endif
