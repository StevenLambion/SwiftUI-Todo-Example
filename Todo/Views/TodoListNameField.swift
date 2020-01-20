import SwiftUI

struct TodoListNameField : View {
  @Binding var name: String
  
  var body: some View {
    TextField("Untitled todo list", text: $name)
    .font(.title)
    .padding()
  }
}

#if DEBUG
public enum TodoListNameField_Previews: PreviewProvider {
  
  struct PreviewWrapper: View {
    @State private var name = "Todo List"
    
    var body: some View {
      TodoListNameField(name: $name)
    }
  }
  
  public static var previews: some View {
    PreviewWrapper()
  }
}
#endif
