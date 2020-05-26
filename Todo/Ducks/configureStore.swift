import Foundation
import SwiftDux
import SwiftDuxExtras
import AppNavigation

func configureStore() -> Store<AppState> {
  Store(
    state: AppState(),
    reducer: TodoListsReducer() + TodosReducer() + NavigationReducer(),
    middleware: (
      NavigationMiddleware() +
      PersistStateMiddleware(JSONStatePersistor()) { state in
        state.schemaVersion == AppState.currentSchemaVersion
      }
    )
  )
}
