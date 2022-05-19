//
//  OKResref.m
//  Manfred
//
//  Created by Rick Shafer on Mon Apr 28 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKResref.h"
#import "OKResource.h"


@implementation OKResref
+(OKResref *) withNamePtr: (char *) newNamePtr code: (unsigned long int) newCode{
    return [[self alloc] initWithNamePtr: newNamePtr code: newCode];
}
-(OKResref *) initWithNamePtr: (char *) newNamePtr code: (unsigned long int) newCode {
    [super init];
    int i;
    for (i=0 ; i < 16 ; i++) theResref.name[i] = newNamePtr[i];
    theResref.code = newCode;
    return self;
}
-(NSString *) description {
    return [[self name]
        stringByAppendingFormat: @".%@", [[OKResource typeForCode:theResref.code]lowercaseString]];
}
-(NSString *) name
{
    int i;
    for (i = 0; (i<16) && (theResref.name[i] != 0); i++);
    return [NSString stringWithCString: theResref.name length: i];
}
-(long int) code
{
    return theResref.code;
}
@end
