import SwiftUI
import Combine
import SwiftDux

struct TodoListDetailsContainer : View {
  
  @MappedState private var todoList: TodoList
  @MappedDispatch() private var dispatch
  
  @SwiftUI.State private var editMode: EditMode = .inactive
  
  var body: some View {
    VStack {
      TodoListDetailsNameContainer().connect()
      renderList()
    }
    .navigationBarTitle(Text(""), displayMode: .inline)
      .navigationBarItems(
        //leading: self.renderLeadingNavigationButton(),
        trailing: AddButton { self.dispatch(TodosAction.addTodo(text: "New Todo")) }
    )
    .environment(\.editMode, $editMode)
    .onDisappear {
      self.dispatch(MainSceneAction.selectList(byId: nil))
    }
  }
  
  func renderList() -> some View {
    List {
      ForEach(todoList.todos) { todo in
        TodoListDetailsRowContainer().connect(with: todo.id)
      }
      .onMove { self.dispatch(TodosAction.moveTodos(from: $0, to: $1)) }
      .onDelete { self.dispatch(TodosAction.removeTodos(at: $0)) }
    }
  }
  
  func renderLeadingNavigationButton() -> some View {
    TodoListDetailsBackButton { self.dispatch(MainSceneAction.selectList(byId: nil)) }
  }

}
  
extension TodoListDetailsContainer : ParameterizedConnectable {
  
  func updateWhen(action: Action, with parameter: String) -> Bool {
    action is TodosAction
  }
  
  func map(state: AppState, with parameter: String) -> TodoList? {
    state.todoLists[parameter]
  }
  
}
