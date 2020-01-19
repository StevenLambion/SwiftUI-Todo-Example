import SwiftUI
import SwiftDux

extension TodoListBrowserContainer {

  struct RowContainer : View {
    @MappedState private var props: Props
    
    var onSelectRow: (String) -> ()
    
    var body: some View {
      NavigationLink(destination: renderTodoList(), isActive: props.selected) {
        TodoListRow(name: props.name)
      }
    }
    
    func renderTodoList() -> some View {
      TodoListContainer()
        .connect(with: props.id)
    }
  }
  
}

extension TodoListBrowserContainer.RowContainer : ParameterizedConnectable {
  
  struct Props {
    var id: String
    var name: String
    var selected: Binding<Bool>
  }
  
  func map(state: AppState, with parameter: String, binder: StateBinder) -> Props? {
    guard let todoList = state.todoLists[parameter] else { return nil }
    return Props(
      id: parameter,
      name: todoList.name,
      selected: binder.bind(state.selectedTodoListId == parameter) {
        if $0 {
          self.onSelectRow(parameter)
        }
        return nil
      }
    )
  }
  
}

#if DEBUG
public enum TodoListBrowserContainerRowContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    Store(
      state: AppState(),
      reducer: AppReducer()
    )
  }
  
  public static var previews: some View {
    TodoListBrowserContainer.RowContainer(onSelectRow: { _ in })
      .connect(with: "123")
    .provideStore(store)
  }
  
}
#endif
