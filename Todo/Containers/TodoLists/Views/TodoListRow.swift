import SwiftUI

struct TodoListRow : View {
  var name: String
  
  var body: some View {
    Text(verbatim: name)
  }
}
