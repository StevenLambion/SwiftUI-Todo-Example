import SwiftUI

struct CheckedToggleStyle : ToggleStyle {
  
  func makeBody(configuration: ToggleStyleConfiguration) -> some View {
    let color: Color = configuration.isOn ? .green : .secondary
    let iconName = configuration.isOn ? "checkmark.circle.fill" : "circle"
    return Button(action: { configuration.isOn = !configuration.isOn }) {
      Image(systemName: iconName)
        .imageScale(.large).padding()
        .foregroundColor(color)
    }
  }
  
}
