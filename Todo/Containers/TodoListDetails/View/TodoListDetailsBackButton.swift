import SwiftUI

struct TodoListDetailsBackButton : View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  
  var onPress: ()->()
  
  var body: some View {
    Group {
      if horizontalSizeClass == .compact {
        Button(action: onPress) {
          HStack {
            Image(systemName: "chevron.left").imageScale(.large)
            Text("Todo Lists")
          }
        }
      } else {
        EmptyView()
      }
    }
  }
}
