import SwiftUI
import SwiftDux

struct MainSceneView : View {
  
  var body: some View {
    NavigationView {
      TodoListsContainer().connect()
      AnyView(Text("Select a todo list."))
    }
  }
  
}
