import SwiftUI

struct AddButton : View {
  
  var onAdd: ()->()
  
  var body: some View {
    Button(action: onAdd) {
      Image(systemName: "plus").imageScale(.large).padding()
    }
  }
}
