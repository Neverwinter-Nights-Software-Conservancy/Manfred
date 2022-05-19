#import "OKDatrefProperty.h"
#import "OKPropertyResource.h"

@implementation OKDatrefProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    unsigned long int length, buffer;
    [variableData getBytes: &buffer range: NSMakeRange(elementInfo.offset,4)];
    length = NSSwapLittleLongToHost(buffer);
    value = [[variableData subdataWithRange: NSMakeRange(elementInfo.offset+4,length)]
        retain];
    return;
}
-(NSString *) type
{
    return @"Datref";
}


@end
