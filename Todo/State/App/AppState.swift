import Foundation
import SwiftDux
import SwiftUI

func createTodos() -> [Todo] {
  let count = 1
  var todos = [Todo]()
  todos.reserveCapacity(count)
  for i in 0..<count {
    todos.append(Todo(id: "\(i)", text: "Todo \(i)"))
  }
  return todos
}

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
  var mainScene: MainScene
  var todoLists: OrderedState<TodoList>
  
  init(
    mainScene: MainScene = MainScene(),
    todoLists: OrderedState<TodoList> = defaultTodoList
  ) {
    self.mainScene = mainScene
    self.todoLists = todoLists
  }
}
