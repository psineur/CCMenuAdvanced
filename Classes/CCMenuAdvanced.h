//
//  CCMenuAdvanced.h
//  Cocos2D Extenstions for iTraceur
//
//  Created by Stepan Generalov on 27.02.11.
//  Copyright 2011 Parkour Games. All rights reserved.
//

#import "cocos2d.h"

@interface NSString (UnicharExtensions)

+ (NSString *) stringWithUnichar: (unichar) anUnichar;
- (unichar) unicharFromFirstCharacter: (NSString *) aString;

@end


// CCMenuAdvanced adds these features to CCMenu:
//		1) Selecting and activating CCMenuItems with Keyboard (by default next/prev
// bindings aren't set - set them manually or use one of align methods to 
// bind arrows for this.
//		2) One of CCMenuItems can be set as escapeDelegate - so it will be activated by pressing escape
//		3) align left->right, right->left, bottom->top, top->bottom with autosetting self contentSize
//		4) externalBoundsRect - if it is set then menu items will be scrollable inside these bounds
//		5) priority property - must be set before onEnter to make it register with that priority
@interface CCMenuAdvanced : CCMenu  
{
	NSInteger priority_;
	int selectedItemNumber_;
	
	CGRect boundaryRect_; //< external boundaries in which menu can slide
	CGFloat minimumTouchLengthToSlide_; //< how long user must slide finger to start scrolling menu
	CGFloat curTouchLength_;

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
	// menu item that can be fast activated byt pressing Esc
	CCMenuItem *escapeDelegate_;
	// button bindings for next/prev item select
	unichar prevItemButtonBind_;
	unichar nextItemButtonBind_;	
#endif
}

@property(readwrite, assign) CGRect boundaryRect;
@property(readwrite, assign) CGFloat minimumTouchLengthToSlide;
@property(readwrite, assign) NSInteger priority;

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
@property(readwrite, retain) CCMenuItem *escapeDelegate;
@property(readwrite, assign) unichar prevItemButtonBind;
@property(readwrite, assign) unichar nextItemButtonBind;
#endif

#pragma mark Advanced Menu - Align
// alignHorizontal from left to right
-(void) alignItemsHorizontallyWithPadding:(float)padding;

// designated alignVerticall from bottom to top
-(void) alignItemsVerticallyWithPadding:(float)padding;

// designated alignHorizontal Method
-(void) alignItemsHorizontallyWithPadding:(float)padding leftToRight: (BOOL) leftToRight;

// designated alignVerticall Method
-(void) alignItemsVerticallyWithPadding:(float)padding bottomToTop: (BOOL) bottomToTop;

#pragma mark Advanced Menu - Scrolling

// changes menu position to stay inside of boundaryRect if it is non-null
- (void) fixPosition;

@end
