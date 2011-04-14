//
//  DemoMenu.m
//  CCMenuAdvanced-mac
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoMenu.h"


@implementation DemoMenu

- (id) init
{
	if (self = [super init])
	{
		_backgroundLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 255) ];
		[self addChild:_backgroundLayer];
		
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"allDemoElements.plist"
																 textureFile: @"allDemoElements.png" ];
		
		_cornerSil = [CCSprite spriteWithSpriteFrameName:@"rightBigLogo.png"];
		[self addChild: _cornerSil];
		
		_nameLogo = [CCSprite spriteWithSpriteFrameName:@"topCaption.png"];
		[self addChild: _nameLogo];
		
		_widget = [DemoMenuWidget node];
		[self addChild: _widget];
		
		// update positions and scalex of children
		[self updateForScreenReshape];
		
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
	// size of window
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	// background to fit the window
	[_backgroundLayer setContentSize: winSize];
	
	// caption must be not more that 1/5 window height, and must not be overscaled
	_nameLogo.scale = (winSize.height / 5.0f) / ([_nameLogo contentSize].height);
	_nameLogo.scale = MIN(_nameLogo.scale, 1.0f);
	
	// position caption at top center
	_nameLogo.anchorPoint = ccp(0.5f, 1.0f );
	_nameLogo.position = ccp(winSize.width / 2.0f, winSize.height);	
	
	// BG silhouette must fit on screen in height and 1/2 of screen in width
	_cornerSil.scale = (winSize.width / 2.0f) / [_cornerSil contentSize].width;
	_cornerSil.scale = MIN(_cornerSil.scale, winSize.height /  [_cornerSil contentSize].height);
	_cornerSil.scale = MIN(_cornerSil.scale, 1.0f);
	
	
	// positoin BG Silhouette
	_cornerSil.anchorPoint = ccp(1,0);
	_cornerSil.position = ccp(winSize.width, 0); 
	
	
	
	// active Size is space that left for menu after caption
	CGSize activeSize = CGSizeMake( winSize.width, 
								   winSize.height - _nameLogo.scale * [_nameLogo contentSize].height);
	
	//scale and position menu widget
	_widget.scale = (winSize.width / 2.0f) / [_widget contentSize].width;
	_widget.scale = MIN(_widget.scale, activeSize.height / [_widget contentSize].height);
	_widget.scale = MIN(_widget.scale, 1.0f);
	_widget.anchorPoint = ccp(0, 0.5);
	_widget.position = ccp(0, activeSize.height / 2.0f);
}

@end



@implementation DemoMenuWidget 

- (id) init
{
	if ( (self = [super init]) )
	{
		//TODO: init widget here
	}

	return self;
}
	

@end
