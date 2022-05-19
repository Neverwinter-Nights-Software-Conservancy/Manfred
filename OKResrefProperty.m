#import "OKResrefProperty.h"
#import "OKPropertyResource.h"

@implementation OKResrefProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    unsigned char length;
    unsigned long int longLength;
    [variableData getBytes: &length range: NSMakeRange(elementInfo.offset,1)];
    longLength = length;
    char * stringBuffer = malloc(longLength);
    [variableData getBytes: stringBuffer range: NSMakeRange(elementInfo.offset+1,
    longLength)];
    value = [[NSString stringWithCString: stringBuffer length:longLength] retain];
    free(stringBuffer);
    return;
}
-(NSString *) type
{
    return @"Resref";
}

@end
