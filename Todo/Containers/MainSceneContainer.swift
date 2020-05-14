import SwiftUI
import SwiftDux
import AppNavigation

struct MainSceneContainer : View {
  var store: Store<AppState>
  
  var body: some View {
    RootNavigationView {
      StackNavigationView {
        TodoListBrowserContainer()
      }
    }
    .provideStore(store)
    .provideStore(store, as: NavigationStateRoot.self)
  }
}

#if DEBUG
public enum MainSceneContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
    MainSceneContainer(store: store)
  }
}
#endif
