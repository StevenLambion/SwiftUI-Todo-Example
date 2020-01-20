import SwiftUI

public struct AddButton : View {
  public var onAdd: ()->()
  
  public var body: some View {
    Button(action: onAdd) {
      Image(systemName: "plus").imageScale(.large).padding()
    }
  }
}

#if DEBUG
public enum AddButton_Previews: PreviewProvider {
  
  public static var previews: some View {
    AddButton() {  }
  }
  
}
#endif
