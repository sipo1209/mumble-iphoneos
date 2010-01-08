/* Copyright (C) 2009-2010 Mikkel Krautz <mikkel@krautz.dk>

   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:

   - Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation
     and/or other materials provided with the distribution.
   - Neither the name of the Mumble Developers nor the names of its
     contributors may be used to endorse or promote products derived from this
     software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR
   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "AppDelegate.h"
#import "AboutDialog.h"
#import "AboutViewController.h"

@implementation AboutDialog

- (id) init {
	self = [super init];
	if (self == nil)
		return nil;

	NSString *aboutTitle = [NSString stringWithFormat:@"Mumble (%@) 1.2.0", @"{{gitrev}}"];
	NSString *aboutMessage = @"Low-latency, high-quality VoIP app";

	alert = [[UIAlertView alloc] initWithTitle:aboutTitle message:aboutMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	websiteButton = [alert addButtonWithTitle:@"Website"];
	contribButton = [alert addButtonWithTitle:@"Contributors"];
	legalButton = [alert addButtonWithTitle:@"Legal"];

	return self;
}
- (void) dealloc {
	[super dealloc];
	[alert release];
}

- (void) show {
	[alert show];
}

- (void) alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	if (buttonIndex == websiteButton) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mumble.info/"]];
	} else if (buttonIndex == contribButton) {
		AboutViewController *contrib = [[[AboutViewController alloc] initWithContent:@"Contributors"] autorelease];
		[[appDelegate navigationController] pushViewController:contrib animated:YES];
	} else if (buttonIndex == legalButton) {
		AboutViewController *legal = [[[AboutViewController alloc] initWithContent:@"Legal"] autorelease];
		[[appDelegate navigationController] pushViewController:legal animated:YES];
	}
	[self release];
}

+ (void) show {
	AboutDialog *about = [[AboutDialog alloc] init];
	[about show];
	// AboutDialog will release itself when done. This is not a leak!
}

@end