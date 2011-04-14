//
//  DemoMenu.h
//  CCMenuAdvanced
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class DemoMenuWidget;

// Main Demo Menu Node
@interface DemoMenu : CCNode 
{
	// weak refs of node childs
	CCLayerColor *_backgroundLayer;	
	
	CCSprite *_cornerSil;
	CCSprite *_nameLogo;
	
	DemoMenuWidget *_widget;	
}

- (void) updateForScreenReshape;

@end


// The Menu itself of Demo Screen
@interface DemoMenuWidget : CCNode
{
}

@end

