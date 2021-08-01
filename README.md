# README #

Here's what you will find in FinalFourLab.

### Language ###
The project was written in Swift.

### SwiftUI ###
A target was added -- FinalFourSwiftUI -- to demo a different detail view.  To try it, select FinalFourSwiftUI target and run the app.  Only the detail is SwiftUI, master is UIKit.
The entire app is UIKit for target FinalFourLab.

### Adaptive Layout ###
The newly designed UISplitViewController is used with style doubleColumn to support all size classes.

### UICollectionViewCompositionalLayout ###
The collection view grid is using the new layout functionality from UICollectionViewCompositionalLayout.

### UIContentConfiguration ###
The collection view cell is using the new UIContentConfiguration to manage cell content.

### Combine ###
Combine was used to make the model observable and react to changes on the property *favorite*

### Known Issues ###
For target FinalFourLab, navigation from master to detail is choppy.  This does not happen when running FinalFourSwiftUI.
For target FinalFourSwiftUI, in DetailVeiwController, the product artwork was coded to have a fixed size for all selections -- not getting that behavior.  
Most images look right, but certain ones are smaller than specified.

### UI Tests ###
Unit tests have been included with special emphasis on the rule engine and game events.
