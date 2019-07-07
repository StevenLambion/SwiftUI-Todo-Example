import SwiftUI

struct TodosView : View {
  @State private var editMode: EditMode = .active
  
  var todoList: TodoList
  var onTodoListNameChange: (String) -> ()
  var onTodoTextChange: (String, String) -> ()
  var onAddTodo: () -> ()
  var onMoveTodos: (IndexSet, Int) -> ()
  var onRemoveTodos: (IndexSet) -> ()
  
  private var todoListName: Binding<String> {
    Binding<String>(
      getValue: { self.todoList.name },
      setValue: self.onTodoListNameChange
    )
  }
  
  var body: some View {
    return VStack {
      TextField("Untitled todo list", text: todoListName)
        .font(.title)
        .padding()
      List {
        ForEach(todoList.todos) { todo in
          TodoRow(todo: todo, onTodoTextChange: self.onTodoTextChange)
        }
        .onMove(perform: self.onMoveTodos)
          .onDelete(perform: self.onRemoveTodos)
      }
    }
    .navigationBarTitle(Text(""), displayMode: .inline)
      .navigationBarItems(
        trailing: Button(action: self.onAddTodo) {
          Image(systemName: "plus").imageScale(.large).padding()
        }
    )
      .environment(\.editMode, $editMode)
  }
  
}
