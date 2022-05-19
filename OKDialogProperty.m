//
//  OKDialogProperty.m
//  Manfred
//
//  Created by Rick Shafer on Tue May 06 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKDialogProperty.h"


@implementation OKDialogProperty
- (NSString *) name
{
    return @"Dialog String at index";
}
- (NSNumber *) codeOrID
{
    return [NSNumber numberWithUnsignedLong: resourceIndex];
}
- (NSNumber *) outlineViewIndex
{
    return [NSNumber numberWithUnsignedLong: resourceIndex];
}
- (id) outlineViewValue
{
    return [NSNumber numberWithUnsignedLong: resourceIndex];
}
-(NSString *) type
{
    return @"Dialog";
}

@end
