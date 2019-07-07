import SwiftUI

struct TodoListRow : View {
  var name: String
  var selected: Bool
  
  var body: some View {
    Text(name.isEmpty ? "Untitled todo list" : name)
  }
}
