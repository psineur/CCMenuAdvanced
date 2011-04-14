//
//  DemoMenu2.h
//  CCMenuAdvanced-mac
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GenericDemoMenu.h"

// Demo Menu with list, like TimeTrial menu in iTraceur
// demonstrates how menu ca be build as a subclass of GenericDemoMenu
@interface DemoMenu2 : GenericDemoMenu 
{
	//Right Silhouette
	CCSprite *_sil;
	
	// Left List of something (videos, levels, etc)
	CCNode * _widget;
	
	// Faders on top and bottom - to fade the list
	CCSprite *_topBorder, *_bottomBorder;
}

@end
