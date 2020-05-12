import Foundation
import SwiftDux
import SwiftDuxExtras
import AppNavigation

func configureStore() -> Store<AppState> {
  Store(
    state: AppState(),
    reducer: TodoListsReducer() + TodosReducer() + NavigationReducer(),
    middleware: (
      PersistStateMiddleware(JSONStatePersistor()) { state in
        state.schemaVersion == AppState.currentSchemaVersion
      }
    )
  )
}
