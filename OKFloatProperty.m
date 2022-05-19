#import "OKFloatProperty.h"
#import "OKPropertyResource.h"

@implementation OKFloatProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[NSNumber numberWithFloat: elementInfo.floatValue] retain];
    return;
}
-(NSString *) type
{
    return @"Float";
}

@end
