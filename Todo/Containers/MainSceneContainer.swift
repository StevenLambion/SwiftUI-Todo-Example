import SwiftUI
import SwiftDux

struct MainSceneContainer : View {
  var store: Store<AppState>
  
  var body: some View {
    NavigationView {
      TodoListBrowserContainer()
      Text("Select a todo list.")
    }.provideStore(store)
  }
}

#if DEBUG
public enum MainSceneContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    MainSceneContainer(store: store)
  }
}
#endif
