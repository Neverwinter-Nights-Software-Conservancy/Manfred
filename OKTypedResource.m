//
//  OKTypedResource.m
//  Manfred
//
//  Created by Rick Shafer on Mon Apr 21 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKTypedResource.h"


@implementation OKTypedResource
-(OKResource *) initWithData:(NSData *)newData in:(id)aContainer as:(NSString *)anIdentifier
{
    [super initWithData: newData in: aContainer as:anIdentifier];
    unsigned char aBuffer[4];
    unsigned int dataLength = [newData length];
    if (dataLength > 3) {
        [newData getBytes: aBuffer range: NSMakeRange(0,4)];
        dataType = [NSString stringWithCString: (const char *) &aBuffer length: 4];
    } else dataType = @"????";
    if (dataLength > 7) {
        [newData getBytes: aBuffer range: NSMakeRange(4,4)];
        dataVersion = [NSString stringWithCString:(const char *)&aBuffer length:4];
    } else dataVersion = @"????";
    NSLog(@"TypedResource init");
    NSLog(dataType);
    NSLog(dataVersion);
    [dataType retain];
    [dataVersion retain];
    
    return self;
}
- (NSString *) dataType
{
    return dataType;
}
- (NSString *) dataVersion
{
    return dataVersion;
}

@end
