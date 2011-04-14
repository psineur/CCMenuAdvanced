//
//  CCMenuAdvancedAppDelegate.h
//  CCMenuAdvanced
//
//  Created by Stepan Generalov on 14.04.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface CCMenuAdvancedAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
