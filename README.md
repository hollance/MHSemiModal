# UIViewController+MHSemiModal

This is a category on UIViewController that makes it easy to present modal view controllers that only partially cover the screen.

Instead of:

`[self presentModalViewController:controller animated:YES];`

You now do:

`[self mh_presentSemiModalViewController:controller animated:YES];`

To dismiss the semi-modal view controller, you do:

`[self mh_dismissSemiModalViewController:controller animated:YES];`

Tested on iOS 4 and iOS 5 (no ARC).
