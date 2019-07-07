import SwiftUI
import SwiftDux

struct DetailNavigation<Content> : View where Content : View {
  
  var presented: Bool
  var content: () -> Content
  
  var link = NavigationDestinationLink(
    TodoListsContainer.todoItemList(),
    isDetail: true
  )
  
  var body: some View {
    link.presented?.value = presented
    return content()
  }
  
}
