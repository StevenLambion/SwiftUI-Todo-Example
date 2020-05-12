import SwiftUI
import AppNavigation

struct TodoListRow : View {
  var todoList: TodoList
  
  var body: some View {
    RouteLink(path: todoList.id) {
      Text(verbatim: self.todoList.name.isEmpty ? "Untitled todo list" : self.todoList.name)
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
        TodoListRow(todoList: todoList)
      }
    }
  }
  
  public static var previews: some View {
    PreviewWrapper()
  }
}
#endif
