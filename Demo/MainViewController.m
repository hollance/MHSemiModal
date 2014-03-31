
#import "MainViewController.h"
#import "SecondViewController.h"
#import "UIViewController+MHSemiModal.h"

@implementation MainViewController

- (IBAction)showAction:(id)sender
{
	SecondViewController *controller = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
	[self mh_presentSemiModalViewController:controller animated:YES];
}

@end
