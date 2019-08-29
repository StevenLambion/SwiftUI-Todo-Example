import SwiftUI

struct TodoListDetailsRow : View {
  @Binding var completed: Bool
  @Binding var text: String
  
  var body: some View {
    HStack {
      Toggle(isOn: $completed) { EmptyView() }
        .toggleStyle(CheckedToggleStyle())
      TextField("", text: $text)
    }
  }
}
