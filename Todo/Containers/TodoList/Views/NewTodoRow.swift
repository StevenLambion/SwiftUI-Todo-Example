import SwiftUI
import SwiftDux

struct NewTodoRow : View {
  @Binding var text: String
  var onAddTodo: (String) -> ()
  
  var body: some View {
    TextField("New todo", text: $text, onCommit: onEnter)
  }
  
  func onEnter() {
    onAddTodo(text)
    text = ""
  }

}

#if DEBUG
public enum NewTodoRow_Previews: PreviewProvider {
  
  struct PreviewWrapper: View {
    @State private var text = ""
    
    var body: some View {
      NewTodoRow(text: $text) { _ in
        print("Added...")
        self.text = ""
      }
    }
  }
  
  public static var previews: some View {
    PreviewWrapper()
  }
  
}
#endif
