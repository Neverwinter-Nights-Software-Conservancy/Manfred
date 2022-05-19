#import "OKCaprefProperty.h"
#import "OKPropertyResource.h"

@implementation OKCaprefProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    value = [[resource entryPropertyAtIndex: elementInfo.offset] retain];
    return;
}
- (int)numberOfChildren
{
    return 1;
}
- (OKProperty *) child: (int) index
{
    return value;
}
- (id) outlineViewValue
{
    return @"";
}
-(NSString *) type
{
    return @"Capref";
}
- (void) dumpValueInHTMLTo: (NSMutableData *) dumpData
{
    NSStringEncoding icode = [NSString defaultCStringEncoding];
    [dumpData appendData: [ @"<code>[***] = </code>\n" dataUsingEncoding:icode]];
    [value dumpHTMLTo: dumpData];
}



@end
