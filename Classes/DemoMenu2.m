//
//  DemoMenu2.m
//  CCMenuAdvanced-mac
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoMenu2.h"
#import "CCMenuAdvanced.h"
#import "DemoMenu.h"

@interface DemoMenu2 (Private)

// update leftSideWidget behavior
- (void) updateWidget;

// returns new autoreleased CCSprite for right side
- (CCSprite *) rightSideSilSprite;

// returns new autoreleased widget for left side - must be reimplemented in subclasses
- (CCNode *) leftSideWidget;


@end


@implementation DemoMenu2

- (id) init
{
	if (self = [super init]) 
	{
		// Load Sprites
		_sil = [self rightSideSilSprite];
		if (_sil)
			[self addChild: _sil z: DEMO_MENU_Z_COVER];				
		
		if ( (_widget = [self leftSideWidget]) )
			[self addChild: _widget z: DEMO_MENU_Z_CONTENT];
		
		//borders		
		_topBorder = [CCSprite spriteWithSpriteFrameName:@"FaderTop.png"];
		_bottomBorder = [CCSprite spriteWithSpriteFrameName:@"FaderBottom.png"];
		[self addChild: _topBorder z: DEMO_MENU_Z_BORDERS];
		[self addChild: _bottomBorder z: DEMO_MENU_Z_BORDERS];
		[[_topBorder texture] setAliasTexParameters];
		
		// update positions and scalex of children
		[self updateForScreenReshape];
	}
	
	return self;
}


- (void) updateForScreenReshape
{
	[super updateForScreenReshape];
	
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	CGSize activeSize = CGSizeMake(winSize.width, winSize.height - _caption.contentSize.height);
	
	// sil
	if (_sil)
	{
		_sil.scale = activeSize.height / _sil.contentSize.height;
		_sil.scale = MIN(_sil.scale, (winSize.width / 2.0f) / _sil.contentSize.width);
		_sil.scale = MIN(_sil.scale, 1.0f);
		
		_sil.anchorPoint = ccp(1, 0.5f);
		_sil.position = ccp(winSize.width, activeSize.height / 2.0f);
	}
	
	[self updateWidget];
	
	//borders
	_topBorder.scaleX = winSize.width / _topBorder.contentSize.width;
	_topBorder.anchorPoint = ccp(0,1);
	_topBorder.position = ccp(0, winSize.height);
	
	_bottomBorder.scaleX = winSize.width / _bottomBorder.contentSize.width;
	_bottomBorder.anchorPoint = ccp(0,0);
	_bottomBorder.position = ccp(0, 0);
}

- (CCSprite *) rightSideSilSprite
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"allDemoElements.plist" 
															 textureFile:@"allDemoElements.png" ];
	
	return [CCSprite spriteWithSpriteFrameName:@"listBigLogoRight.png"];
}

- (NSString *) captionSpriteFrameName
{
	return @"listMenuCaption.png";
}

- (NSArray *) menuItemsArray
{	
	NSArray *array = [NSArray arrayWithObjects:
					  [CCMenuItemLabel itemWithLabel:[CCLabelBMFont labelWithString: @"Level #1" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"Level #2" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel:[CCLabelBMFont labelWithString: @"Level #3" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel:[CCLabelBMFont labelWithString: @"Level +10050" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"Level #nil" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"Level Kill" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"Level Kill Bill" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"Whatever..." fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"Oh, commoooooOON!!!" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"Fork you!" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"FORK YOU!!!" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"..." fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"...." fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"..." fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  
					  [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString:@"WAAAZAAAAAAAA!!! =)" fntFile:@"crackedGradient42.fnt"]
											  target: self 
											selector: @selector(itemPressed:)],
					  nil  ];
	
	return array;
}


- (CCNode *) leftSideWidget
{
	// Get Menu Items
	NSArray *menuItems = [self menuItemsArray];
	
	// Prepare Menu
	CCMenuAdvanced *menu = [CCMenuAdvanced menuWithItems: nil];	
	for (CCMenuItem *item in menuItems)
		[menu addChild: item];		
	
	// Setup Menu Alignment
	[menu alignItemsVerticallyWithPadding: 5 bottomToTop: NO]; //< also sets contentSize and keyBindings on Mac
	menu.isRelativeAnchorPoint = YES;	
	
	return menu;
}

- (void) updateWidget
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	CGSize activeSize = CGSizeMake(winSize.width, winSize.height - _caption.contentSize.height);
	
	CCMenuAdvanced *menu = (CCMenuAdvanced *) _widget; 
	
	//widget	
	menu.anchorPoint = ccp(0.5f, 1);
	menu.position = ccp(winSize.width / 4, winSize.height - _caption.contentSize.height);
	
	menu.scale = MIN ((winSize.width / 2.0f) / _widget.contentSize.width, 0.75f );
	
	menu.boundaryRect = CGRectMake(MAX(0, winSize.width / 4.0f - [menu boundingBox].size.width / 2.0f), 
								   [_bottomBorder boundingBox].size.height, 
								   [menu boundingBox].size.width,
								   (activeSize.height - [_bottomBorder boundingBox].size.height));
	
	[menu fixPosition];	
}


- (void) itemPressed: (CCNode *) sender
{
	NSLog(@"DemoMenu2#itemPressed: %@", sender);
}

// I like to use GameDirector for calls from menus (such as buttons pressed)
// but here is too simple example or this, so i will just import DemoMenu to DemoMenu2.h
// and change scene right from here
//
// But it's recommended to have something like GameManager class, and 
// all Scene changes must be called only from there
- (void) backPressed
{	
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// Add Demo Menu
	DemoMenu *menu = [DemoMenu node];
	menu.anchorPoint = menu.position = ccp(0,0);
	
	// add layer as a child to scene
	[scene addChild: menu];
	
	// change scene
	[[CCDirector sharedDirector] replaceScene: scene];
}

@end