//
//  GenericDemoMenu.m
//  CCMenuAdvanced
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GenericDemoMenu.h"
#import "CCMenuAdvanced.h"


@implementation GenericDemoMenu

- (id) init
{
	if ( (self = [super init]) )
	{
		_background = [CCColorLayer layerWithColor:ccc4(0, 0, 0, 255)];
		[self addChild:_background z:DEMO_MENU_Z_BACKGROUND];
		
		// Ensure that we have needed Sprite Frame 
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"allDemoElements.plist"
																 textureFile: @"allDemoElements.png" ];
		
		// Create back button
		CCSprite *backButton = [CCSprite spriteWithSpriteFrameName:@"backButton.png"];
		CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"backButtonSelected.png"];
		_backMenuItem = [CCMenuItemSprite itemFromNormalSprite: backButton
												selectedSprite: backButtonSelected
														target: self
													  selector: @selector(backPressed)
						 ];
		CCMenuAdvanced *menu = [CCMenuAdvanced menuWithItems:_backMenuItem, nil];
		
		// Bind keyboard for mac
#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
		menu.escapeDelegate = _backMenuItem;
#endif
		menu.anchorPoint = ccp(0,0);
		menu.position = ccp(0,0);
		[self addChild:menu z:DEMO_MENU_Z_BACK_BUTTON];
		
		// Setup Caption
		_caption = [CCSprite spriteWithSpriteFrameName:[self captionSpriteFrameName]];
		[self addChild:_caption z: DEMO_MENU_Z_CAPTION];
	}
	
	return self;
}

- (void) onExit
{
	[self removeAllChildrenWithCleanup:YES];
	[super onExit];
}

- (void) dealloc
{
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	
	[super dealloc];
}

- (void) updateForScreenReshape
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	_backMenuItem.anchorPoint = ccp(0.0f,1.0f);
	_backMenuItem.position = ccp(0, winSize.height);
	
	[_background setContentSize: winSize ];
	
	_caption.anchorPoint = ccp(0.5, 1);
	_caption.position = ccp(winSize.width / 2.0f, winSize.height);	
	
}

- (NSString *) captionSpriteFrameName
{
	NSAssert(NO, @"iTraceurMenu#captionSpriteFrameName called! This method should be reimplemented.");
	return @"PARKOUR!!!";
}

- (void) backPressed
{	
	/**** Commented in CCMenuAdvanced demo, cause i don't have GameDirector here ***
	//FORWARD this msg to GD with iTraceurMenu subclass as sender
	[[GameDirector sharedGameDirector] iTraceurMenuBackPressed: self ];
	 */
}

@end