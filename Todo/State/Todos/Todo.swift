import Foundation
import SwiftUI
import SwiftDux

struct Todo: IdentifiableState, Identifiable {
  var id: String
  var text: String
}
