//
//  CCMenuAdvanced_macAppDelegate.m
//  CCMenuAdvanced-mac
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "CCMenuAdvanced_macAppDelegate.h"
#import "HelloWorldLayer.h"

@implementation CCMenuAdvanced_macAppDelegate
@synthesize window=window_, glView=glView_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	
	[director setDisplayFPS:YES];
	
	[director setOpenGLView:glView_];

	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	[director setResizeMode:kCCDirectorResize_NoScale];
	
	// Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:NO];
	
	// Start listening to resizeWindow notification
	[director.openGLView setPostsFrameChangedNotifications: YES];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(updateForScreenReshape:) 
												 name: NSViewFrameDidChangeNotification 
											   object: director.openGLView];
	
	
	[director runWithScene:[HelloWorldLayer scene]];
}


- (void) updateForScreenReshape: (NSNotification *) aNotification
{
	CCScene *curScene = [[CCDirector sharedDirector] runningScene];
	
	if (curScene)
	{
		for (CCNode *child in curScene.children)
			if ([child respondsToSelector:@selector(updateForScreenReshape)])
				[child performSelector:@selector(updateForScreenReshape)];
	}
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
	
	[[CCDirector sharedDirector] release];
	[window_ release];
	[super dealloc];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
	
	[self updateForScreenReshape: nil];
}

@end
