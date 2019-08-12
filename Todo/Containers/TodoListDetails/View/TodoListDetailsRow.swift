import SwiftUI

struct TodoListDetailsRow : View {
  @Binding var text: String
  
  var body: some View {
    TextField("", text: $text)
  }
}
