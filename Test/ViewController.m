
#import "ViewController.h"
#import "SecondViewController.h"
#import "UIViewController+MHSemiModal.h"

@implementation ViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)showAction:(id)sender
{
	SecondViewController *controller = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
	[self mh_presentSemiModalViewController:controller animated:YES];
	[controller release];
}

@end
