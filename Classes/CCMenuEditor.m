//
//  CCMenuEditor.m
//  iTraceur for Mac
//
//  Created by Stepan Generalov on 23.12.10.
//  Copyright 2010 Parkour Games. All rights reserved.
//

#import "CCMenuEditor.h"


@implementation CCMenuEditor

+ (id) menuEditorWithPropertyListName: (NSString *) propertyListName
{
	return [[[self alloc] initWithPropertyListName: propertyListName] autorelease];
}

- (id) initWithPropertyListName: (NSString *) propertyListName
{
	if (self = [super init])
	{
		_elementsArray = [[[self class] loadArrayFromPropertyListWithName: propertyListName] retain];
	}
	return self;
}

- (void) dealloc
{
	[_elementsArray release];
	[super dealloc];
}

- (CGPoint) positionForElementWithName: (NSString *) imageName
{
	return [ [self class] positionForElementWithName: imageName fromArray: _elementsArray];
}


+ (NSArray *) loadArrayFromPropertyListWithName: (NSString *) propertyListName
{
	NSAssert(propertyListName, @"CCMenuEditor#loadArrayFromPropertyListWithName: listName must not be nil!");
	
	// cut ".plist" if it exists
	NSMutableString *nameString = [propertyListName mutableCopy];
	NSRange range = [nameString rangeOfString:@".plist"];
	if (range.length > 0)
		[nameString deleteCharactersInRange: range ];
	
	NSArray *elementsArray = 
	[ [NSArray alloc]  initWithContentsOfFile: 
	 [ [NSBundle mainBundle] pathForResource: nameString ofType: @"plist"]];
	
	return [elementsArray autorelease];
}

+ (CGPoint) positionForElementWithName: (NSString *) imageName 
							 fromArray:  (NSArray  *) anArray
{
	CGPoint elPosition;
	
	
	BOOL found = NO;
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	for ( NSDictionary *dict in anArray )
    {        
        NSString *spriteName = [ dict valueForKey: @"spriteName"  ];
		
		if ([spriteName isEqualToString: imageName])
		{
			
			NSNumber  *x = [ dict valueForKey: @"x" ];
			NSNumber  *y = [ dict valueForKey: @"y" ];
			NSNumber  *width = [dict valueForKey: @"width"];
			NSNumber  *height = [dict valueForKey: @"height"];
			
			elPosition = CGPointMake( (float)[x intValue] + (float)[width intValue] / 2.0f ,
									 (float)[y intValue] + (float)[height intValue] / 2.0f);
			
			found = YES;
			break;
		}
		
	}
	
	[pool release];
	
	if (!found)
	{
		NSLog(@"CCMenuEditor#positionForElementWithName:%@fromArray%@ not found!", imageName, anArray);
		return CGPointZero;
	}
	
	return elPosition;
}
@end
