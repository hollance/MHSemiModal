
#import "SecondViewController.h"
#import "UIViewController+MHSemiModal.h"

@implementation SecondViewController

- (void)dealloc
{
	NSLog(@"dealloc %@", self);
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	NSLog(@"viewDidAppear %@", self);
}

- (IBAction)dismissAction
{
	[self mh_dismissSemiModalViewController:self animated:YES];
}

@end
