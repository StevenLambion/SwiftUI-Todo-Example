import SwiftUI
import SwiftDux

struct MainSceneView : View {
  
  var body: some View {
    NavigationView {
      TodoListsContainer()
      AnyView(Text("Select a todo list."))
    }
  }
  
}
