import Foundation
import SwiftDux

struct Todo: IdentifiableState {
  var id: String
  var text: String
  var completed: Bool = false
}
