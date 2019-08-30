import Foundation
import SwiftDux

fileprivate let defaultTodoList = OrderedState(
  TodoList(
    id: "123",
    name: "Shopping List",
    todos: OrderedState(
      Todo(id: "1", text: "Eggs"),
      Todo(id: "2", text: "Milk"),
      Todo(id: "3", text: "Coffee")
    )
  )
)

struct AppState : StateType {
  
  static let currentSchemaVersion = 1
  
  var schemaVersion: Int = currentSchemaVersion
  var mainScene: MainScene = MainScene()
  var todoLists: OrderedState<TodoList> = defaultTodoList

}
