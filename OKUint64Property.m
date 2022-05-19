#import "OKUint64Property.h"
#import "OKPropertyResource.h"

@implementation OKUint64Property
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    unsigned long long int buffer;
    [variableData getBytes: &buffer range: NSMakeRange(elementInfo.offset,8)];
    value = [
            [NSNumber numberWithUnsignedLongLong:
                                    NSSwapLittleLongLongToHost(buffer)] 
        retain];
    return;
}
-(NSString *) type
{
    return @"U64";
}

@end
