import Foundation
import SwiftDux

struct Todo: StateType, Identifiable {
  var id: String
  var text: String
  var completed: Bool = false
}
