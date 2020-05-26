import SwiftUI
import AppNavigation

struct TodoListRow : View {
  var todoList: TodoList
  var selected: Bool
  
  var body: some View {
    RouteLink(path: "todoList/\(todoList.id)", isDetail: true) {
      Text(verbatim: self.todoList.name.isEmpty ? "Untitled todo list" : self.todoList.name)
    }.listRowBackground(selected ? Color(red: 0.83, green: 0.83, blue: 0.85) : Color.white)
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
        TodoListRow(todoList: todoList, selected: false)
      }
    }
  }
  
  public static var previews: some View {
    PreviewWrapper()
  }
}
#endif
