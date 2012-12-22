
#import "SecondViewController.h"
#import "UIViewController+MHSemiModal.h"

@implementation SecondViewController

- (void)dealloc
{
	NSLog(@"dealloc %@", self);
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

- (IBAction)dismissAction
{
	[self mh_dismissSemiModalViewController:self animated:YES];
}

@end
