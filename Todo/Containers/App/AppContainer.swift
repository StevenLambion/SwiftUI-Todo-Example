import SwiftUI
import SwiftDux

struct AppContainer : View {
  var store: Store<AppState>
  
  var body: some View {
    NavigationView {
      TodoListBrowserContainer().connect()
      AnyView(Text("Select a todo list."))
    }.provideStore(store)
  }
  
}

#if DEBUG
public enum AppContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    Store(
      state: AppState(),
      reducer: AppReducer()
    )
  }
  
  public static var previews: some View {
    AppContainer(store: store)
  }
  
}
#endif
