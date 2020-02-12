import SwiftDux

protocol TodosRoot {
  var todos: [String:Todo] { get set }
}
