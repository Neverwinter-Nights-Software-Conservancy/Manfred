//
//  ResourceInspector.m
//  Manfred
//
//  Created by Rick Shafer on Mon Jun 16 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ResourceInspector.h"


@implementation ResourceInspector
-(ResourceInspector *) initWithResource: (OKResource *) newResource owner: (id) newOwner
{
    [self initWithWindowNibName: [self windowNibName] owner: newOwner];
    resource = [newResource retain];
    return self;
}

-(void) dealloc
{
    [resource release];
    [super dealloc];
}
-(NSString *) windowNibName
{
    return NSStringFromClass([self class]);
}
@end
