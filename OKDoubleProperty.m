#import "OKDoubleProperty.h"
#import "OKPropertyResource.h"

@implementation OKDoubleProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    NSSwappedDouble buffer;
    [variableData getBytes: &buffer range: NSMakeRange(elementInfo.offset,8)];
    value = [
            [NSNumber numberWithDouble:NSSwapLittleDoubleToHost(buffer)] 
        retain];
    return;
}
-(NSString *) type
{
    return @"Double";
}

@end
