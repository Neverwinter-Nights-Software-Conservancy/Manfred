#import "OKUint16Property.h"
#import "OKPropertyResource.h"

@implementation OKUint16Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[NSNumber numberWithUnsignedShort: elementInfo.ui16.value] retain];
    return;
}
-(NSString *) type
{
    return @"U16";
}

@end
