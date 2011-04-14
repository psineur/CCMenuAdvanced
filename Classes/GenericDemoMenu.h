//
//  GenericDemoMenu.h
//  CCMenuAdvanced
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define DEMO_MENU_Z_BACKGROUND			1
#define DEMO_MENU_Z_CONTENT				2
#define DEMO_MENU_Z_BORDERS				3
#define DEMO_MENU_Z_COVER				4
#define DEMO_MENU_Z_CAPTION				5
#define DEMO_MENU_Z_BACK_BUTTON			6
#define DEMO_MENU_Z_OVER_BACK_BUTTON	7

// Abstract Menu Screen, that was used in iTraceur 
// as a subclass for Choose Leve, Time Trial & Game Progress Menus
@interface GenericDemoMenu : CCNode 
{
	// weak refs to self children
	CCSprite *_caption;
	CCLayerColor *_background;
	CCMenuItem *_backMenuItem;
}

// must be reimplemented in subclasses, 
// should return sprite frame name for caption sprite at the top
- (NSString *) captionSpriteFrameName;

// must be called from subclasses implementation of method
- (void) updateForScreenReshape;

@end
