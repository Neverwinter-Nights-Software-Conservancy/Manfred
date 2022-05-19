#import "OKInt64Property.h"
#import "OKPropertyResource.h"

@implementation OKInt64Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    long long int buffer;
    [variableData getBytes: &buffer range: NSMakeRange(elementInfo.offset,8)];
    value = [
            [NSNumber numberWithLongLong:NSSwapLittleLongLongToHost(buffer)] 
        retain];
    return;
}
-(NSString *) type
{
    return @"I64";
}

@end
