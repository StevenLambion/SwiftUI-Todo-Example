import SwiftUI

struct TodoRow : View {
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

#if DEBUG
public enum TodoRow_Previews: PreviewProvider {
  
  struct StateWrapper: View {
    @State var completed: Bool = false
    @State var text: String = "A Todo"
    
    var body: some View {
      TodoRow(
        completed: $completed,
        text: $text
      )
    }
  }
  
  public static var previews: some View {
    StateWrapper()
  }
  
}
#endif
