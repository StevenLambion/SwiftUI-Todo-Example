# SwiftDux Todo App

A reference implementation of a todo app to test out SwiftUI using [SwiftDux](https://github.com/StevenLambion/SwiftDux). This example is still a work in progress. There's partial iPad support, but SwiftUI's split view and navigation functionality is still not fully complete.

<div style="text-align: center">
  <div>
    <img style="inline" src="./screenshots/todoLists-iPad-screenshot.png" width="600"/>
  </div>
</div>

## Things left to do:

Some of the items below are possible now if using a custom built SplitView and deprecated APIs. The point of this project though is to see where SwiftUI is at while it develops. It's still in an early preview stage, so many parts of it are in flux or missing.

- Multi-window support with UIScene.
- Initially selected todo list on iPad.
- Split view navigation button to expand / collapse the master view.
  - This is currently missing. It was also missing in the SwiftUI Essentials video.
- Remove arrows from master view on iPad.
  - This is an implemenation detail of NavigationLink.
- Autofocus text fields when adding a new item.
- Persist state.
- Restore previous navigation on relaunch.
