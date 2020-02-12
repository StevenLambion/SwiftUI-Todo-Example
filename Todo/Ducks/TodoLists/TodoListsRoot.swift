import SwiftDux

protocol TodoListsRoot: TodosRoot {
  var todoLists: OrderedState<TodoList> { get set }
  var selectedTodoListId: String? { get set }
}
