#import "OKUint32Property.h"
#import "OKPropertyResource.h"

@implementation OKUint32Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[NSNumber numberWithUnsignedLong: elementInfo.ui32Value] retain];
    return;
}
-(NSString *) type
{
    return @"U32";
}

@end
