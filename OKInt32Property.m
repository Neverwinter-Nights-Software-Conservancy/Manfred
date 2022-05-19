#import "OKInt32Property.h"
#import "OKPropertyResource.h"

@implementation OKInt32Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[NSNumber numberWithLong: elementInfo.i32Value] retain];
    return;
}
-(NSString *) type
{
    return @"I32";
}

@end
