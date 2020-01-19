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
