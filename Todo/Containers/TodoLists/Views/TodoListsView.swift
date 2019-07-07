import SwiftUI
import SwiftDux

struct TodoListsView<Details> : View where Details : View {
  @Environment(\.editMode) var mode
  
  var selectedListId: String?
  var todoLists: OrderedState<TodoList>
  var renderDetailContainer: (TodoList) -> Details
  var onAddTodoList: () -> ()
  var onMoveTodoLists: (IndexSet, Int) -> ()
  var onRemoveTodoLists: (IndexSet) -> ()
  
  var body: some View {
    return (
      List {
        ForEach(todoLists) { list in
          NavigationLink(destination: self.renderDetailContainer(list)) {
            TodoListRow(name: list.name, selected: self.selectedListId == list.id)
          }
        }
        .onMove(perform: self.onMoveTodoLists)
        .onDelete(perform: self.onRemoveTodoLists)
      }
      .navigationBarTitle(Text("Todo Lists"))
      .navigationBarItems(
        leading: EditButton(),
        trailing: Button(action: self.onAddTodoList) {
          Image(systemName: "plus").imageScale(.large).padding()
        }
      )
    )
  }
  
}
