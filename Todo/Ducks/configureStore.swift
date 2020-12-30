import Foundation
import SwiftDux
import SwiftDuxExtras
import AppNavigation

func configureStore() -> Store<AppState> {
  let middleware = (
    NavigationMiddleware<AppState>() +
    PrintActionMiddleware() +
    PersistStateMiddleware(JSONStatePersistor()) { state in
      state.schemaVersion == AppState.currentSchemaVersion
    }
  )
  return Store(
    state: AppState(),
    reducer: TodoListsReducer() + TodosReducer() + NavigationReducer(),
    middleware: middleware
  )
}
