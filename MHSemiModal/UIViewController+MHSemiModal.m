/*
 * Copyright (c) 2011-2012 Matthijs Hollemans
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "UIViewController+MHSemiModal.h"

static const int CoverViewTag = 88888888;

@implementation UIViewController (MHSemiModal)

- (UIView *)mh_coverViewForViewController:(UIViewController *)viewController
{
	return [viewController.parentViewController.view viewWithTag:CoverViewTag];
}

- (void)mh_presentSemiModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	UIView *coverView = [[UIView alloc] initWithFrame:self.view.bounds];
	coverView.backgroundColor = [UIColor blackColor];
	coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	coverView.alpha = 0.0f;
	coverView.tag = CoverViewTag;
	[self.view addSubview:coverView];

	CGRect rect = self.view.bounds;
	rect.origin.y += rect.size.height;
	viewController.view.frame = rect;
	[self.view addSubview:viewController.view];

	[self addChildViewController:viewController];

	if (animated)
	{
		[UIView animateWithDuration:0.4 animations:^
		{
			[self mh_afterPresentAnimation:viewController];
		}];
	}
	else
	{
		[self mh_afterPresentAnimation:viewController];
	}
}

- (void)mh_afterPresentAnimation:(UIViewController *)viewController
{
	viewController.view.frame = self.view.bounds;

	UIView *coverView = [self mh_coverViewForViewController:viewController];
	coverView.alpha = 0.5f;

	[viewController didMoveToParentViewController:self];
}

- (void)mh_dismissSemiModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController willMoveToParentViewController:nil];

	if (animated)
	{
		[UIView animateWithDuration:0.4 animations:^
		{
			CGRect rect = viewController.view.bounds;
			rect.origin.y += rect.size.height;
			viewController.view.frame = rect;

			UIView *coverView = [self mh_coverViewForViewController:viewController];
			coverView.alpha = 0.0f;
		}
		completion:^(BOOL finished)
		{
			[self mh_afterDismissAnimation:viewController];
		}];
	}
	else
	{
		[self mh_afterDismissAnimation:viewController];
	}
}

- (void)mh_afterDismissAnimation:(UIViewController *)viewController
{
	UIView *coverView = [self mh_coverViewForViewController:viewController];
	[coverView removeFromSuperview];

	[viewController removeFromParentViewController];
	[viewController.view removeFromSuperview];
}

@end
