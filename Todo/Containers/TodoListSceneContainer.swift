import SwiftUI
import SwiftDux

struct TodoListSceneContainer : View {
  var todoListId: String
  var store: Store<AppState>
  
  var body: some View {
    NavigationView {
      TodoListContainer(id: todoListId)
      AnyView(Text("Select a todo list."))
    }.provideStore(store)
  }
}

#if DEBUG
public enum TodoListSceneContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    TodoListSceneContainer(todoListId: "123", store: store)
  }
}
#endif
