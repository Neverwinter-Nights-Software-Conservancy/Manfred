#import "OKInt8Property.h"
#import "OKPropertyResource.h"

@implementation OKInt8Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[NSNumber numberWithChar: elementInfo.i8.value] retain];
    return;
}
-(NSString *) type
{
    return @"I8";
}

@end
