#import "OKStringProperty.h"
#import "OKPropertyResource.h"

@implementation OKStringProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    unsigned long int buffer, length;
    [variableData getBytes: &buffer range: NSMakeRange(elementInfo.offset,4)];
    length = NSSwapLittleLongToHost(buffer);
    char * stringBuffer = malloc(length);
    [variableData getBytes: stringBuffer range: NSMakeRange(elementInfo.offset+4,
    length)];
    value = [[NSString stringWithCString: stringBuffer length:length] retain];
    free(stringBuffer);
    return;
}
-(NSString *) type
{
    return @"String";
}

@end
