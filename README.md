# iOSHomeTask1

Check attached image for details.


1. First Part: UI

First VC is view controller with tableview wrapped inside navigation controller.

If “+” tapped second view controller should be presented with fields being empty.

If cell is tapped than second view controller should be presented with fields filled with data from the cell.


2. Second Part: Logic

If “Back” button is pressed on second view controller than all changes done should be discarded, second view controller should be dismissed and first view controller should become visible.

If “Add” button taped than all the changes done should be passed to first view controller. First view controller should be updated with new info.

If “Add” button tapped prior any changes have been done first view controller’s table view should skip updating.


Second view controller should notify first view controller on “Back” button and “Add” button tap with NSNotification.

Second view controller should deliver information added by the user to the first view controller through the call to custom delegate method or completion.
