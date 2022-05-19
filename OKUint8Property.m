#import "OKUint8Property.h"
#import "OKPropertyResource.h"
@implementation OKUint8Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[NSNumber numberWithUnsignedChar: elementInfo.ui8.value] retain];
    return;
}
-(NSString *) type
{
    return @"U8";
}
@end