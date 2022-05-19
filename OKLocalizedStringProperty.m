//
//  OKLocalizedStringProperty.m
//  Manfred
//
//  Created by Rick Shafer on Tue May 06 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKLocalizedStringProperty.h"
#import "OKPropertyResource.h"


@implementation OKLocalizedStringProperty
+(OKLocalizedStringProperty *) fromVariableData: (NSData *)variableData withCursor: (unsigned long int *) cursor in: (OKPropertyResource *) theResource
{
    unsigned long int intBuffer[2];
    [variableData getBytes: intBuffer range:NSMakeRange(cursor[0],8)];
    struct okLocalizedStringHeader localizedStringHeader;
    okSwapMultipleLongs(intBuffer, &localizedStringHeader, 2);
    OKLocalizedStringProperty *localizedString = [[OKLocalizedStringProperty alloc] initWithResource:theResource at:localizedStringHeader.languageCode];
    char * charBuffer = malloc(localizedStringHeader.length);
    [variableData getBytes: charBuffer range:NSMakeRange(cursor[0]+8,localizedStringHeader.length)];
    [localizedString setValue: [NSString stringWithCString: charBuffer length: localizedStringHeader.length]];
    free(charBuffer);
    cursor[0] +=  8 + localizedStringHeader.length;
    return localizedString;
}
-(void)dealloc
{
    [value release];
    [super dealloc];
    return;
}
-(void)setValue: (NSString *)aString
{
    [aString retain];
    [value release];
    value = aString;
}
-(NSNumber *)languageCode
{
    return [NSNumber numberWithLong: resourceIndex];
}
-(NSString *) name
{
    return @"Localized String";
}
- (NSNumber *) codeOrID
{
    return [NSNumber numberWithLong: resourceIndex];
}
- (NSNumber *) outlineViewIndex
{
    return [NSNumber numberWithUnsignedLong: resourceIndex];
}
- (id) outlineViewValue
{
    return value;
}
-(NSString *) type
{
    return @"LocString";
}

@end
