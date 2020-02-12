import Foundation
import SwiftDux
import SwiftDuxExtras

func configureStore() -> Store<AppState> {
  Store(
    state: AppState(),
    reducer: TodoListsReducer() + TodosReducer(),
    middleware: (
      PersistStateMiddleware(JSONStatePersistor()) { state in
        state.schemaVersion == AppState.currentSchemaVersion
      }
    )
  )
}
