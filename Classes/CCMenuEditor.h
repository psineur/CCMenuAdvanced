//
//  CCMenuEditor.h
//  iTraceur for Mac
//
//  Created by Stepan Generalov on 23.12.10.
//  Copyright 2010 Parkour Games. All rights reserved.
//

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
	#import <Cocoa/Cocoa.h>
#endif

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
	#import <Foundation/Foundation.h>
#endif


@interface CCMenuEditor : NSObject 
{
	NSArray *_elementsArray;
}

#pragma mark Interface

+ (id) menuEditorWithPropertyListName: (NSString *) propertyListName;

- (id) initWithPropertyListName: (NSString *) propertyListName;

- (CGPoint) positionForElementWithName: (NSString *) imageName;

#pragma mark Old Interface
+ (NSArray *) loadArrayFromPropertyListWithName: (NSString *) propertyListName;

+ (CGPoint) positionForElementWithName: (NSString *) imageName 
							 fromArray:  (NSArray  *) anArray;

@end
