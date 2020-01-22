import Foundation
import SwiftDux

fileprivate let defaultTodoList = OrderedState(
  TodoList(
    id: "123",
    name: "Shopping List",
    newTodoText: "",
    todoIds: ["1", "2", "3"]
  ),
  TodoList(
    id: "123456",
    name: "Very Large Todo List",
    newTodoText: "",
    todoIds: Array(4...1000).map { String($0) }
  )

)

fileprivate let defaultTodos = [
  "3": Todo(id: "3", text: "Coffee"),
  "1": Todo(id: "1", text: "Eggs"),
  "2": Todo(id: "2", text: "Milk")
  ]
  .merging(Array(4...1000).reduce([String:Todo]()) {
    var todos = $0
    let id = String($1)
    todos[id] = Todo(id: id, text: "Todo number: \($1)")
    return todos
  }) { (_, new) in new }

struct AppState : StateType {
  static let currentSchemaVersion = 2
  
  var schemaVersion: Int = currentSchemaVersion
  var todoLists: OrderedState<TodoList> = defaultTodoList
  var todos: [String:Todo] = defaultTodos
  var selectedTodoListId: String? = nil
}
