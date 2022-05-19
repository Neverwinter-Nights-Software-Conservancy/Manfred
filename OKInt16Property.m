#import "OKInt16Property.h"
#import "OKPropertyResource.h"

@implementation OKInt16Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[NSNumber numberWithShort: elementInfo.i16.value] retain];
    return;
}
-(NSString *) type
{
    return @"I16";
}

@end
