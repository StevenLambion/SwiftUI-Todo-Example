import Foundation
import SwiftDux

fileprivate let defaultTodoList = OrderedState(
  TodoList(
    id: "123",
    name: "Shopping List",
    newTodoText: "",
    todoIds: ["1", "2", "3"]
  )
)

fileprivate let defaultTodos = [
  "3": Todo(id: "3", text: "Coffee"),
  "1": Todo(id: "1", text: "Eggs"),
  "2": Todo(id: "2", text: "Milk")
]

struct AppState : StateType {
  static let currentSchemaVersion = 2
  
  var schemaVersion: Int = currentSchemaVersion
  var mainScene: MainScene = MainScene()
  var todoLists: OrderedState<TodoList> = defaultTodoList
  var todos: [String:Todo] = defaultTodos
  var selectedTodoListId: String? = nil

}
