import SwiftUI

struct TodoListRow : View {
  var todoList: TodoList
  @Binding var selectedId: String?
  
  var body: some View {
    Button(action: self.selectTodoList) {
      Text(verbatim: self.todoList.name.isEmpty ? "Untitled todo list" : self.todoList.name)
    }
    .listRowBackground(selectedId == todoList.id
      ? Color(red: 0.83, green: 0.83, blue: 0.85)
      : Color.white
    )
  }
  
  func selectTodoList() {
    selectedId = todoList.id
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
        TodoListRow(todoList: todoList, selectedId: .constant(nil))
      }
    }
  }
  
  public static var previews: some View {
    PreviewWrapper()
  }
}
#endif
