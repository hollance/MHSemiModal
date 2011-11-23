/*!
 * \file UIViewController+MHSemiModal.m
 *
 * Copyright (c) 2011 Matthijs Hollemans
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

static UIView *coverView = nil;

@implementation UIViewController (MHSemiModal)

- (void)mh_afterPresentAnimation:(UIViewController *)viewController
{
	viewController.view.frame = self.view.bounds;
	coverView.alpha = 0.5f;

	if ([viewController respondsToSelector:@selector(didMoveToParentViewController:)])
		[viewController didMoveToParentViewController:self];
}

- (void)mh_presentSemiModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController retain];

	coverView = [[UIView alloc] initWithFrame:self.view.bounds];
	coverView.backgroundColor = UIColor.blackColor;
	coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	coverView.alpha = 0.0f;
	[self.view addSubview:coverView];
	[coverView release];

	CGRect rect = self.view.bounds;
	rect.origin.y += rect.size.height;
	viewController.view.frame = rect;
	[self.view addSubview:viewController.view];

	if ([viewController respondsToSelector:@selector(didMoveToParentViewController:)])
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

- (void)mh_afterDismissAnimation:(UIViewController *)viewController
{
	if ([viewController respondsToSelector:@selector(willMoveToParentViewController:)])
		[viewController removeFromParentViewController];

	[coverView removeFromSuperview];
	coverView = nil;

	[viewController.view removeFromSuperview];
	[viewController autorelease];
}

- (void)mh_dismissSemiModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	// Note: The coverView is a static global var for compatibility with iOS 4,
	// which doesn't have the containment API and therefore the presented view
	// controller has no pointer back to its parentViewController. If it did,
	// we could haved simply asked the parent's view for the cover view using
	// a tag. That is cleaner but unfortunately only works on iOS 5.

	if ([viewController respondsToSelector:@selector(willMoveToParentViewController:)])
		[viewController willMoveToParentViewController:nil];

	if (animated)
	{
		[UIView animateWithDuration:0.4 animations:^
		{
			CGRect rect = viewController.view.bounds;
			rect.origin.y += rect.size.height;
			viewController.view.frame = rect;
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

@end
