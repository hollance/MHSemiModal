
#import "SecondViewController.h"
#import "UIViewController+MHSemiModal.h"

@implementation SecondViewController

- (void)dealloc
{
	NSLog(@"dealloc %@", self);
	[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	NSLog(@"viewDidAppear");
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	NSLog(@"willRotateToInterfaceOrientation");
}

- (IBAction)dismissAction
{
	[self mh_dismissSemiModalViewController:self animated:YES];
}

@end
