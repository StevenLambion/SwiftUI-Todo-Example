import SwiftUI
import SwiftDux

struct TodoListsView : View {
  @Environment(\.editMode) var mode
  
  var detailsLink = DynamicNavigationDestinationLink(id: \.id, isDetail: true) { (list: TodoList) in
    TodosContainer(id: list.id)
  }
  
  var todoLists: OrderedState<TodoList>
  
  @Binding var selectedTodoList: TodoList?
  
  var onAddTodoList: () -> ()
  var onMoveTodoLists: (IndexSet, Int) -> ()
  var onRemoveTodoLists: (IndexSet) -> ()
  
  var body: some View {
    detailsLink.presentedData?.value = selectedTodoList
    return (
      List {
        ForEach(todoLists) { list in
          NavigationLink(destination: list, in: self.$selectedTodoList) {
            TodoListRow(name: list.name, selected: self.selectedTodoList?.id == list.id)
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
