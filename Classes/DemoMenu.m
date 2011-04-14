//
//  DemoMenu.m
//  CCMenuAdvanced-mac
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoMenu.h"
#import "CCMenuAdvanced.h"
#import "CCMenuEditor.h"
#import "CCMenuItemSpriteIndependent.h"
#import "DemoMenu2.h"


@implementation DemoMenu

- (id) init
{
	if ( (self = [super init]) )
	{
		_backgroundLayer = [CCLayerColor layerWithColor: ccc4(0x86, 0xbd, 0xb7, 255) ];
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
		// Be sure to have needed Sprites Frames loaded
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"allDemoElements.plist"
																 textureFile: @"allDemoElements.png" ];
		
		// Get all universal sprites
		CCSprite *dummyButton1 = [CCSprite spriteWithSpriteFrameName:@"dummyButton1.png"];
		CCSprite *dummyButton1Selected = [CCSprite spriteWithSpriteFrameName:@"dummyButton1Selected.png"];
		
		CCSprite *dummyButton2 = [CCSprite spriteWithSpriteFrameName:@"dummyButton2.png"];
		CCSprite *dummyButton2Selected = [CCSprite spriteWithSpriteFrameName:@"dummyButton2Selected.png"];
		
		CCSprite *listButton = [CCSprite spriteWithSpriteFrameName:@"listButton.png"];
		CCSprite *listButtonSelected = [CCSprite spriteWithSpriteFrameName:@"listButtonSelected.png"];		
		

		
		// Prepare Universal Menu Items
		CCMenuItemSpriteIndependent *dummyMenuItem1 = 
		[CCMenuItemSpriteIndependent itemFromNormalSprite: dummyButton1
										   selectedSprite: dummyButton1Selected
												   target: self
												 selector: @selector(dummyButton1Pressed)
		 ];
		
		CCMenuItemSpriteIndependent *dummyMenuItem2 = 
		[CCMenuItemSpriteIndependent itemFromNormalSprite: dummyButton2
										   selectedSprite: dummyButton2Selected
												   target: self
												 selector: @selector(dummyButton2Pressed)
		 ];
		
		CCMenuItemSpriteIndependent *listMenuItem = 
		[CCMenuItemSpriteIndependent itemFromNormalSprite: listButton
										   selectedSprite: listButtonSelected
												   target: self
												 selector: @selector(listButtonPressed)
		 ];
		
				
				
		// Layout Menu Items
		self.contentSize = CGSizeMake(410, 277); 
		//< well, this is bad. CCMenuEditor doesn't give me info about xcf size, so it's hardcoded.
		//< I should add size of xcf into xcf2sprites or use another editor. Looking forward to CocosBuilder ;)
		
		CCMenuEditor *editor = [CCMenuEditor menuEditorWithPropertyListName:@"demoMenuWidgetLayout"];
		//< note .plist extension not required 
		
		// position menu items from normal sprite position in xcf
		dummyMenuItem1.position = [editor positionForElementWithName: @"dummyButton1.png"];
		dummyMenuItem2.position = [editor positionForElementWithName: @"dummyButton2.png"];
		listMenuItem.position = [editor positionForElementWithName: @"listButton.png"];
		
		
		// position normal independent sprites at the same points
		dummyButton1.position = [editor positionForElementWithName: @"dummyButton1.png"];
		dummyButton2.position = [editor positionForElementWithName: @"dummyButton2.png"];
		listButton.position = [editor positionForElementWithName: @"listButton.png"];
		
		// position selected independent sprites at their positions (other that normal, cause they have different sizes)
		dummyButton1Selected.position = [editor positionForElementWithName: @"dummyButton1Selected.png"];
		dummyButton2Selected.position = [editor positionForElementWithName: @"dummyButton2Selected.png"];
		listButtonSelected.position = [editor positionForElementWithName: @"listButtonSelected.png"];
		
		// add independent sprites as children, cause MenuItem only retains them, not adding
		[self addChild: dummyButton1];
		[self addChild: dummyButton1Selected];
		[self addChild: dummyButton2];
		[self addChild: dummyButton2Selected];		
		[self addChild: listButton];		
		[self addChild: listButtonSelected];
		
		//fix retina scaleDown
		
		/*
		 if (! trainingButton.textureAtlas.texture.isRetina )
		*/
		
		//< wihout this line HD resources will be scaled, when it's not needed
		//< isRetina doesn't exist in official cocos2d, so i will not use this check here
		//< cause i know that these buttons doesn't have retinaResource and i can always 
		//< upscale them with CONTENT_SCALE_FACTOR
		//< You can got isRetina method from this pull request:
		//< https://github.com/cocos2d/cocos2d-iphone/pull/50
		
		{
			dummyButton1.scale *= CC_CONTENT_SCALE_FACTOR();		
			dummyButton1Selected.scale *= CC_CONTENT_SCALE_FACTOR();
			dummyMenuItem1.scale *= CC_CONTENT_SCALE_FACTOR();
			
			dummyButton2.scale *= CC_CONTENT_SCALE_FACTOR();		
			dummyButton2Selected.scale *= CC_CONTENT_SCALE_FACTOR();
			dummyMenuItem2.scale *= CC_CONTENT_SCALE_FACTOR();
			
			listButton.scale *= CC_CONTENT_SCALE_FACTOR();		
			listButtonSelected.scale *= CC_CONTENT_SCALE_FACTOR();
			listMenuItem.scale *= CC_CONTENT_SCALE_FACTOR();
			
		}
		
		
		// Create CCMenuAdvanced
		CCMenuAdvanced *menu = [CCMenuAdvanced menuWithItems: dummyMenuItem1, dummyMenuItem2, listMenuItem, nil];
		menu.anchorPoint = ccp(0,0);
		menu.position = ccp(0,0);
		
		//add keyboard bindings for mac
#if defined(__MAC_OS_X_VERSION_MAX_ALLOWED)
		menu.nextItemButtonBind = NSDownArrowFunctionKey;
		menu.prevItemButtonBind = NSUpArrowFunctionKey;
#endif
		
		[self addChild: menu];
		
	}
	
	return self;
}

- (void) dummyButton1Pressed
{
	NSLog(@"dummy button 1 pressed");
}

- (void) dummyButton2Pressed
{
	NSLog(@"dummy button 2 (TWO) pressed");
}

- (void) listButtonPressed
{
	// change to DemoMenu2
	// It's better to change scene in GameManager, but here i use this for fast code
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// Add Demo Menu
	DemoMenu2 *menu = [DemoMenu2 node];
	menu.anchorPoint = menu.position = ccp(0,0);
	
	// add layer as a child to scene
	[scene addChild: menu];
	
	// change scene
	[[CCDirector sharedDirector] replaceScene: scene];
}

@end
